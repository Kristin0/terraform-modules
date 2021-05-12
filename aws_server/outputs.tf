output "ec2_instance_id"{
  value = aws_instance.ec2.*.id
}

output "bastion-dns" {
  value = aws_instance.bastion.public_dns
}

output "bastion-ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion-id" {
  value = aws_instance.bastion.id
}

output "private-ip" {
  value = aws_instance.ec2.*.private_ip
}

output "private-dns" {
  value = aws_instance.ec2.*.private_dns
}

output "private-id" {
  value = aws_instance.ec2.*.id
}
