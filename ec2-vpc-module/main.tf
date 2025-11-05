module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  allowed_ssh_ips    = var.allowed_ssh_ips
}

module "ec2" {
  source                      = "./modules/ec2"
  instance_ami                = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  public_subnet_id            = module.vpc.public_subnet_id
  my_sg_id                    = module.vpc.my_sg_id
}

