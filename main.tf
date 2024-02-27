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
