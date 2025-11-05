resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    "Name" = "${var.vpc_name}_public_subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "${var.vpc_name}_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "${var.vpc_name}_public_route_table"
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
    cidr_blocks = var.allowed_ssh_ips
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  // 아웃바운드 규칙
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
