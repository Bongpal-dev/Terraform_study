// EC2 설정
variable "instance_type" {
  description = "EC2 인스턴스 유형"
  type        = string
}

variable "instance_ami" {
  description = "EC2에 사용할 AMI ID"
  type        = string
}

variable "associate_public_ip_address" {
  description = "EC2 퍼블릭 IP 할당 여부"
  type        = bool
}

variable "public_subnet_id" {
  description = "EC2를 배치할 Public 서브넷 ID"
  type        = string
}

variable "my_sg_id" {
  description = "EC2에 연결할 보안 그룹 ID"
  type        = string
}
