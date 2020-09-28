##### ELB ##############################################################
resource "aws_elb" "infraelb" {
  name = var.elb_name
  subnets = aws_subnet.infra_subnet[*].id
  security_groups = [aws_security_group.infra_elb_sg.id]

  instances = aws_instance.infra_ec2[*].id
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }
  

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }


    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

  tags = { 
    Name = "${local.env_name}-${var.elb_name}-${var.billing_code_tag}"
   }
}









