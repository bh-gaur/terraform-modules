provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "ubuntu-ami"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}

data "http" "my_ip" {
  url = "http://whatismyip.akamai.com"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# security group
resource "aws_security_group" "instance_sg" {
  name        = "instance_sg_${random_id.rand.hex}"
  description = "Instance SecurityGroup ${random_id.rand.hex}"
  vpc_id      = var.vpc_id

  # Required for all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
    cidr_blocks = [var.vpc_cidr, "${data.http.my_ip.body}/32"]
  }
}


# instance
resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  lifecycle {
    ignore_changes = [ami]
  }

  root_block_device {
    volume_type           = var.root_block_device_type
    volume_size           = var.root_block_device_size_in_gb
    delete_on_termination = true
  }

  tags = {
    Name        = var.hostname
    environment = var.environment
    provisioner = "terraform"
    region      = var.region
  }
}

# # secondary volume
# resource "aws_ebs_volume" "secondary_volume" {
#   count             = var.secondary_block_device ? 1 : 0
#   size              = var.secondary_block_device_size_in_gb
#   type              = var.secondary_block_device_type
#   availability_zone = data.aws_availability_zones.available.names[0]

#   tags = {
#     Name        = var.hostname
#     environment = var.environment
#     provisioner = "terraform"
#     region      = var.region
#   }
# }

# # attach secondary volume
# resource "aws_volume_attachment" "ebs_att" {
#   count       = var.secondary_block_device ? 1 : 0
#   device_name = "/dev/sdf"
#   volume_id   = aws_ebs_volume.secondary_volume[count.index].id
#   instance_id = aws_instance.instance.id
# }