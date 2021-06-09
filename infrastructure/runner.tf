data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  application_name = "runner"
}

resource "aws_instance" "runner" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  vpc_security_group_ids      = [module.vpc.default_security_group_id]
  subnet_id                   = module.vpc.private_subnets[0]
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/templates/runner.tpl", {
    app_name           = local.application_name
    consul_http_addr   = data.hcp_consul_cluster.consul.consul_private_endpoint_url
    consul_ca_file     = data.hcp_consul_cluster.consul.consul_ca_file
    consul_config_file = data.hcp_consul_cluster.consul.consul_config_file
  })

  tags     = merge({ "Name" = local.application_name }, var.tags)
  key_name = module.boundary.boundary_key_name
}