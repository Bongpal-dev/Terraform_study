variable "aws_region" {
  description = "리소스를 배포할 AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "vp_cidr_block" {
  description = "VPC에 할당할 CIDR 블럭"
  type        = string
  default     = "10.0.0.0/16"
}

// 서브넷 설정
variable "subnet_cidr_block" {
  description = "서브넷에 할당할 CIDR 블럭"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_availability_zone" {
  description = "서브넷을 배치 할 가용 영역"
  type        = string
  default     = "ap-northeast-2a"
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

variable "instance_public_ip_address" {
  description = "EC2 퍼블릭 IP 할당 여부"
  type        = bool
  default     = true
}
