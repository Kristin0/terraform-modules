resource "aws_lb" "alb" {
  name = "lb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.allow_http.id]
  subnets = aws_subnet.public.*.id
}

resource "aws_lb_target_group" "target_gr" {
  name = "web-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "elb_attach" {
  count = length(var.instance_id)
  target_group_arn = aws_lb_target_group.target_gr.arn
  target_id = var.instance_id[count.index]
  port = 80
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_gr.arn
  }
    


}