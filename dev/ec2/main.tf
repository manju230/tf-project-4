# -------------------
# Security Group
# -------------------
resource "aws_security_group" "app_sg" {
  name        = "${local.prefix}-app-sg"
  description = "Dedicated SG for App Server"
  vpc_id      = data.aws_vpc.main.id

  # Example: allow SSH from anywhere
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Example: allow HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-sg"
  })
}

# -------------------
# EC2 Instance
# -------------------
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon-linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.app_a.id
  disable_api_termination = false
   associate_public_ip_address = false
 key_name   = "tf-manju"  # Attach SG
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile = data.aws_iam_instance_profile.ec2_profile_data.name

  # Root volume (20 GB gp2)
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  # Additional EBS volume (20 GB gp2)
  ebs_block_device {
    device_name = "/dev/sdf"   # Linux convention, adjust if needed
    volume_size = 30
    volume_type = "gp2"
  }
 user_data = file("./userdata.sh")

  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-server"
  })
}

# -------------------
# Elastic IP
# -------------------
resource "aws_eip" "app_eip" {
  tags = merge(local.comman_tags, {
    Name = "${local.prefix}-app-eip"
  })
}

# -------------------
# Associate EIP with EC2
# -------------------
resource "aws_eip_association" "app_eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = aws_eip.app_eip.id
}
