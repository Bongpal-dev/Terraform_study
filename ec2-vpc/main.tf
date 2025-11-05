terraform {
  required_version = "= 1.13.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=6.19.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
  // access_key = "value"
  // secret_key = "value"
}

# data "local_file" "public_key" {
#   filename = var.public_key_path // 공개키 파일 경로
# }

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "my_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "my_public_subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "my_public_route_table"
  }
}


// 라우팅 테이블, 서브넷 연결
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  // 인바운드 규칙
  ingress {
    // cidr_block = ["599.19.192.5/32"] // my IP 설정
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0    // 모든 포트허용
    to_port     = 0    // 모든 포트허용
    protocol    = "-1" // 모든 포트허용
  }

  tags = {
    "Name" = "my_public_subnet_sg"
  }
}

locals {
  public_key_path = pathexpand("../.ssh/my-key.pub") # 공개 키 파일 경로
}

resource "aws_key_pair" "my_key_pair" {
  public_key = file(local.public_key_path)
  key_name   = "my-key-20251105"
}

resource "aws_instance" "my_ec2" {
  ami                         = "ami-0cf1ead55e8259a57"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_key_pair.key_name

  root_block_device {
    volume_size           = 30    // GB
    volume_type           = "gp3" // gp2, gp3, io1 ...
    delete_on_termination = true  // 인스턴스 종료시 삭제 여부
    encrypted             = false
  }

  tags = {
    "Name" = "my_ec2"
  }
}

// 추가 디스크 설정
resource "aws_ebs_volume" "my_volume" {
  availability_zone = "ap-northeast-2a" // EC2와 같은 가용 영역 설정 필요  
  size              = 10
  type              = "gp2"
  encrypted         = false
  tags = {
    "Name" = "my_ec2_volume"
  }
}

// 추가디스크 - EC2 연결
resource "aws_volume_attachment" "my_volume_attachment" {
  device_name = "/dev/xvdf" // EC2에 마운트 될 디바이스 이름
  instance_id = aws_instance.my_ec2.id
  volume_id   = aws_ebs_volume.my_volume.id
}
