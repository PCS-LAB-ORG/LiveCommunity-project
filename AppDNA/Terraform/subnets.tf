######################
## Public Subnet- 1 ##
#####################

resource "aws_subnet" "public-web-subnet-1" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.public-web-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name           = "Public Subnet 1-${var.environment-name}"
    Owner          = var.custom-name
    Environment    = "appdna"
    ApplicationTag = ""
  }
}

######################
## Public Subnet- 2 ##
#####################

resource "aws_subnet" "public-web-subnet-2" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.public-web-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name           = "Public Subnet 2-${var.environment-name}"
    Owner          = var.custom-name
    ApplicationTag = ""
  }
}

##########################
###    Private Subnet-1  ##
##########################

resource "aws_subnet" "private-app-subnet-1" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.private-app-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name           = "Private Subnet 1 | App Tier -${var.environment-name}"
    Owner          = var.custom-name
    ApplicationTag = ""
  }
}

##########################
###    Private Subnet-2  ##
##########################

resource "aws_subnet" "private-app-subnet-2" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.private-app-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name           = "Private Subnet 2 | App Tier - ${var.environment-name}"
    Owner          = var.custom-name
    ApplicationTag = ""
  }
}

##########################
###    Private Subnet-db 1 ##
##########################

resource "aws_subnet" "private-db-subnet-1" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.private-db-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name           = "Private Subnet 1 | Db Tier - ${var.environment-name}"
    Owner          = var.custom-name
    ApplicationTag = ""
  }
}

##########################
###    Private Subnet-db 2  ##
##########################

resource "aws_subnet" "private-db-subnet-2" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = var.private-db-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name           = "Private Subnet 2 | Db Tier - ${var.environment-name}"
    Owner          = var.custom-name
    ApplicationTag = ""
  }
}