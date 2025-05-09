############################
##   Web app load balancer ##
#############################
resource "aws_lb" "application-load-balancer" {
  name                       = "web-external-lb-${var.environment-name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-security-group.id]
  subnets                    = [aws_subnet.public-web-subnet-1.id, aws_subnet.public-web-subnet-2.id]
  enable_deletion_protection = false

  tags = {
    Name           = "App load balancer - ${var.environment-name}"
    Owner          = var.custom-name
    Environment    = "attackpaths"
    ApplicationTag = "Attackpaths"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "appbalancertg${var.environment-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_01.id
  tags = {
    ApplicationTag = ""
  }
}

resource "aws_lb_target_group_attachment" "web-attachment" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.PublicWebTemplate.id
  port             = 80
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}



# create a listener on port 443 with forward action
/*resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}*/

/*resource "aws_lb_target_group_attachment" "web-attachment" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = aws_instance.PublicWebTemplate.id
  port             = 80
  */

# depends_on = [
#   aws_instance.web-instance
# ]


/*resource "aws_lb_listener" "web-listener" {
#  load_balancer_arn = aws_lb.web-load-balancer.arn
#  port              = 80
#  protocol          = "http"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}*/
