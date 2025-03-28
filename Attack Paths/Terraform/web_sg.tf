###################################
## SG Presentation Tier         ###
###################################
resource "aws_security_group" "webserver-security-group" {
  name        = "Web server Security Group-${var.environment-name}"
  description = "Enable http/https access on port 80/443 via ALB and ssh via ssh sg"
  vpc_id      = aws_vpc.vpc_01.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description     = "http access"
  #   from_port       = 80
  #   to_port         = 80
  #   protocol        = "tcp"
  #   security_groups = ["${aws_security_group.alb-security-group.id}"]
  # }

  # ingress {
  #   description     = "https access"
  #   from_port       = 443
  #   to_port         = 443
  #   protocol        = "tcp"
  #   security_groups = ["${aws_security_group.alb-security-group.id}"]
  # }
  # ingress {
  #   description     = "ssh access"
  #   from_port       = 22
  #   to_port         = 22
  #   protocol        = "tcp"
  #   security_groups = ["${aws_security_group.ssh-security-group.id}"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name           = "Web server Security group-${var.environment-name}"
    Owner          = var.custom-name
    Environment    = "attackpaths"
    ApplicationTag = "Attackpaths"
  }
}