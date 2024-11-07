output "asg_ec2" {
  value = aws_security_group.asg_ec2.id
}

output "private_key" {
  value = nonsensitive(tls_private_key.tls.private_key_pem)
}

output "ec2_instance" {
  value = aws_instance.ec2_instance.id
}

output "ec2_instance_private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "ssh_key_filename" {
  value = local_file.ssh_key.filename
}

