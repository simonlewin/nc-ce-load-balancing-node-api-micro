module "networking" {
  source = "./modules/networking"

  vpc_name   = "microservices"
  cidr_range = "10.0.0.0/20"
}
