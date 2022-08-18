# resource "aws_instance" "awsec2" {
#   count                  = 1
#   ami                    = lookup(var.ec2_ami, var.region)
#   instance_type          = var.instance_type
#   key_name               = "Karthick-keypair"
#   subnet_id              = aws_subnet.public_subnets.id
#   vpc_security_group_ids = [aws_security_group.traffic_ec2.id]
#   user_data              = <<EOF
# #!/bin/bash
# echo "Copying the SSH Key Of Jenkins to the server"
# EOF

#   tags = {
#     "Name" = "${var.name}-ec2-terraform-${count.index}"
#   }
# }
