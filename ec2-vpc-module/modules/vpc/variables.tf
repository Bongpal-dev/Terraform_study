variable "vpc_name" {
  description = "VCD 이름"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC에 할당할 CIDR 블럭"
  type        = string
}

// 서브넷 설정
variable "public_subnet_cidr" {
  description = "서브넷에 할당할 CIDR 블럭"
  type        = string
}

variable "availability_zone" {
  description = "서브넷을 배치 할 가용 영역"
  type        = string
}

variable "allowed_ssh_ips" {
  description = "SSH 허용 IP 목록"
  type        = list(string)
}
