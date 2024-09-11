output "instance-ip-addr" {
  value       = aws_instance.web.public_ip
  description = "Public IP address of the main server instance."
}

output "instance-pvt-ip-addr" {
  value       = aws_instance.web.private_ip
  description = "Private IP address of the main server instance."
}