variable "aws_region" {
  description = "리소스를 배포할 AWS Region"
  type        = string
  default     = "ap-northeast-2"
}


variable "vpc_cidr" {
  description = "VPC CIDR블록"
  type        = string
  default     = "10.0.0.0/16"
}

// VPC설정
variable "vpc_name" {
  description = "VCD 이름"
  type        = string
  default     = "terraform_test_vpc"
}

variable "public_subnet_cidr" {
  description = "퍼블릭 서브넷 CIDR 블럭"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "퍼블릭 서브넷 가용 영역"
  type        = string
  default     = "ap-northeast-2a"
}

variable "allowed_ssh_ips" {
  description = "SSH 허용 IP 목록"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

// EC2 설정
variable "instance_type" {
  description = "EC2 인스턴스 유형"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami" {
  description = "EC2에 사용할 AMI ID"
  type        = string
  default     = "ami-0cf1ead55e8259a57"
}

variable "associate_public_ip_address" {
  description = "EC2 퍼블릭 IP 할당 여부"
  type        = bool
  default     = true
}
