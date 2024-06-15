# outputs.tf

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.windows_instance.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.windows_instance.public_ip
}

output "root_volume_id" {
  description = "The ID of the root EBS volume"
  value       = aws_instance.windows_instance.root_block_device[0].volume_id
}

output "additional_volume_id" {
  description = "The ID of the additional EBS volume"
  value       = aws_ebs_volume.additional_volume.id
}
