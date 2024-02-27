module "networking" {
  source = "./modules/networking"

  vpc_name   = "microservices"
  cidr_range = "10.0.0.0/20"

  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
}

output "public_subnets" {
  value = module.networking.public_subnets
}

output "private_subnets" {
  value = module.networking.private_subnets
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}

output "http" {
  value = module.security.http_group_id
}

output "ssh" {
  value = module.security.ssh_group_id
}

module "app_servers" {
  source = "./modules/app_servers"

  servers                = ["heating", "lighting", "status"]
  vpc_security_group_ids = [module.security.http_group_id, module.security.ssh_group_id]
  subnets                = module.networking.public_subnets
}

resource "aws_instance" "auth_server" {
  ami                    = "ami-0e5f882be1900e43b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.security.http_group_id, module.security.internal_ssh_group_id]
  key_name               = "nc-photo-display-app"
  subnet_id              = module.networking.private_subnets[0]

  tags = {
    Name      = "auth-server"
    ManagedBy = "Terraform"
  }
}

output "app_server_ids" {
  value = module.app_servers.instance_ids
}

module "load_balancer" {
  source = "./modules/load_balancing"

  lb_target_grps = ["heating", "lighting", "status"]
  port           = 3000
  protocol       = "HTTP"
  vpc_id         = module.networking.vpc_id

  instance_ids = module.app_servers.instance_ids
  security_groups = [module.security.http_group_id, module.security.internal_ssh_group_id]
  subnets                = module.networking.public_subnets
}
