resource "aws_security_group" "web" {
  name        = "web"
  vpc_id      = tolist(data.aws_vpcs.my-vpc.ids)[0]
  description = "Allow HTTP/HTTPS"
  tags = {
    Name = "web"
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    cidr_blocks = var.all_ips
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.http_port
    to_port     = var.http_port
    cidr_blocks = var.all_ips
  }

  ingress {
    protocol    = var.tcp_protocol
    from_port   = var.https_port
    to_port     = var.https_port
    cidr_blocks = var.all_ips
  }

  egress {
    protocol    = var.any_protocol
    from_port     = var.any_port
    to_port     = var.any_port
    cidr_blocks = var.all_ips
  }
}