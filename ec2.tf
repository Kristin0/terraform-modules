data "terraform_remote_state" "network" {
   backend = "s3"
   config = {
    bucket = "epam-terraform-state"
    key = "epam/terraform.tfstate"
    region = "us-east-2"
   }
}

data "aws_ami" "ubuntu" {
  most_recent  = true 
  owners = [ "099720109477" ]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "ec2" {
  count = length(var.public_ip_ranges)
  subnet_id = var.subnet_private_ids[count.index]
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [var.security_group_id]
  tags = {
    Name = "ec2-epam-wordpress"
  }
  key_name = var.key_name
}

resource "aws_instance" "bastion" {
  subnet_id = var.subnet_public_ids[0]
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [var.security_group_id]
  tags = {
    Name = "bastion"
  }
  key_name = var.key_name
}
