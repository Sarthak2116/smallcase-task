resource "aws_lb" "test-alb" {
  name               = "sc-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sc-sg.id]
  # subnets            = [for subnet in aws_subnet.my_subnet : subnet.id]

  enable_deletion_protection = true

  tags = {
    Name = "smallcase"
  }
}