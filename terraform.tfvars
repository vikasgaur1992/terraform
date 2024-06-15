# terraform.tfvars

vpc_id            = "vpc-0fe066c4326102d5f"          # Replace with your VPC ID
subnet_id         = "subnet-0dfb4e375495f8783"       # Replace with your subnet ID
security_group_id = "sg-05d05ff5f455f4faf"           # Replace with your security group ID
key_name          = "linus"                    # Replace with your key pair name
ami_id            = "ami-0069eac59d05ae12b"          # Replace with the desired AMI ID
kms_key_id        = "arn:aws:kms:us-east-1:474727059017:key/b54a8b0f-d911-4249-8c30-de7c3ade1b03"  # Replace with your KMS key ARN
allowed_cidr      = "0.0.0.0/0"                      # Replace with your desired CIDR block to allow RDP access
