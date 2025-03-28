################
##### VPC  #####
################


resource "aws_vpc" "vpc_01" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name           = "${var.environment-name}-${var.custom-name}"
    Owner          = var.custom-name
    Environment    = "attackpaths"
    ApplicationTag = "Attackpaths"
  }
}

resource "aws_cloudwatch_log_group" "flowlog_loggroup" {
  name = "loggroup-${var.custom-name}-${var.environment-name}"
  tags = {
    ApplicationTag = ""
  }
}

resource "aws_flow_log" "prisma_flow_log" {
  log_destination      = aws_s3_bucket.flowlog-s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc_01.id
  tags = {
    ApplicationTag = ""
  }
}

resource "aws_s3_bucket" "flowlog-s3" {
  bucket = "${var.custom-name}-flowlogs-${var.environment-name}"

  tags = {
    Name           = "${var.custom-name}-flowlogs"
    Environment    = "attackpaths"
    ApplicationTag = "Attackpaths"
  }
}












