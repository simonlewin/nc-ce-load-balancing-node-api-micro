resource "aws_instance" "app_servers" {
  count = length(var.servers)

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.subnets[count.index]

  associate_public_ip_address = true

  tags = {
    Name      = "${var.servers[count.index]}-server"
    ManagedBy = "Terraform"
  }
}
