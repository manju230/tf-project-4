resource "aws_lb" "alb" {
  name = "project-4-alb"
  internal = false
  load_balancer_type = "application"
   security_groups = [aws_security_group.alb_sg.id]
    subnets = [data.aws_subnet.alb_a.id, data.aws_subnet.alb_b.id]    
    tags = local.common_tags
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default response from ALB"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "project-4-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = local.common_tags
}


resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = data.aws_instance.app_server.id
  port             = 80
}