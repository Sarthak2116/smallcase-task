resource "aws_autoscaling_group" "bar" {
  availability_zones = ["ap-south-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.sc_lt.id
    version = "$Latest"
  }
}