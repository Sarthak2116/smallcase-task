resource "aws_lb_target_group" "test" {
  name     = "sc-lb-tg"
  port     = 8000
  target_type = "alb"
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}