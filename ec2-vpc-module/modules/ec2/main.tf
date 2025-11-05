locals {
  public_key_path = pathexpand("../.ssh/my-key.pub") # 공개 키 파일 경로
}

resource "aws_key_pair" "my_key_pair" {
  public_key = file(local.public_key_path)
  key_name   = "my-key-20251105"
}

resource "aws_instance" "my_ec2" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.my_sg_id]
  associate_public_ip_address = var.associate_public_ip_address
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
