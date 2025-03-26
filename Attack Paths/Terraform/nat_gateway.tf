#####################
#   NAT Gateway #
#####################

resource "aws_eip" "eip_nat" {
  domain   = "vpc"

  tags = {
    Name = "eip1 - ${var.environment-name} - ${var.custom-name}"
    Environment = "attackpaths"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-web-subnet-2.id

  tags = {
    "Name" = "nat1 - ${var.environment-name}"
     Owner = var.custom-name
     Environment = "attackpaths"
  }
}