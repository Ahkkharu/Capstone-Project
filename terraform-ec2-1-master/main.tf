provider "aws" {
  region = var.region
}

resource "aws_key_pair" "my-key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "web" {
  key_name = aws_key_pair.my-key.key_name
  instance_type = var.instance_type
  ami           = var.ami_id
  security_groups = [aws_security_group.web.id]

  subnet_id     = tolist(data.aws_subnet_ids.my-subnets.ids)[0]

  tags = {
    Name = "${var.environment}-instance"
  }
}

