################
##### IGW  #####
################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name           = "IGW-${var.environment-name}"
    Owner          = var.custom-name
    Environment    = "3tiersapp"
    ApplicationTag = "3TiersApp"
  }
}