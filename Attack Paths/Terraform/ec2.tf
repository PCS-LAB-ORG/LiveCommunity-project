########################
###    Data source   ###
########################

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}



##################################
#### KeyPair                   ###
##################################
resource "tls_private_key" "algorithm" {
  count     = var.ec2_key_enabled ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_key_pair" "generated_key" {
  count      = var.ec2_key_enabled ? 1 : 0
  key_name   = "${var.custom-name}-lab2"
  public_key = tls_private_key.algorithm[0].public_key_openssh
}

########################
###    Ec2 Instance  ###
########################


resource "aws_instance" "PublicWebTemplate" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = var.ec2_key_enabled ? aws_key_pair.generated_key[0].key_name : null
  user_data              = file("install-apache.sh")
   metadata_options  {
                    http_tokens = "optional"
                    http_endpoint = "enabled"
  }

  tags = {
    Name  = "web-instance-${var.custom-name}-${var.environment-name}"
    Owner = var.custom-name
    Environment = "attackpaths"
  }
}



##############################
#### EC2 instance Web Tier ###
##############################

/*resource "aws_instance" "PublicWebTemplate" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = var.ec2_key_enabled ? aws_key_pair.generated_key[0].key_name : null
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-asg"
  }
}*/


resource "aws_instance" "private-app-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = var.ec2_key_enabled ? aws_key_pair.generated_key[0].key_name : null
  metadata_options  {
                    http_tokens = "required"
                    http_endpoint = "enabled"
  }
  tags = {
    Name  = "app-instance-${var.custom-name} - ${var.environment-name}"
    Owner = var.custom-name
    Environment = "attackpaths"
  }
}






