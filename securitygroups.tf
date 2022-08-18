data "http" "my_public_ip" {
  url = "https://ifconfig.me"
}

resource "aws_security_group" "traffic_ec2" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.newvpc.id
  depends_on = [
    aws_vpc.newvpc
  ]

  #myip of any address used to access the ec2 instance
  ingress {
    description = "traffic in"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.my_public_ip.body}/32"]
  }

  ingress {
    description = "traffic in"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${data.http.my_public_ip.body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-securitygroup"
  }
}
