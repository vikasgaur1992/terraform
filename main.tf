# main.tf

resource "aws_instance" "windows_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  key_name        = var.key_name

  root_block_device {
    volume_size           = 256  # Size of the C: drive
    volume_type           = "gp2"
    encrypted             = true
    kms_key_id            = var.kms_key_id
    delete_on_termination = false
  }

  ebs_block_device {
    device_name           = "/dev/sdf"  # Device name for the additional D: drive
    volume_size           = 200         # Size of the D: drive
    volume_type           = "gp2"
    encrypted             = true
    kms_key_id            = var.kms_key_id
    delete_on_termination = false
  }

  tags = {
    Name = "WindowsInstance"
  }
}

resource "aws_ebs_volume" "additional_volume" {
  availability_zone = "us-east-1a"  # Replace with your desired availability zone
  size              = 200
#  volume_type       = "gp2"
#volume_type =  each.value["ebs_block_device"]["volume_type"]
  encrypted         = true
  kms_key_id        = var.kms_key_id
  tags = {
    Name = "AdditionalVolume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "xvdb"
  volume_id   = aws_ebs_volume.additional_volume.id
  instance_id = aws_instance.windows_instance.id
}
resource "aws_security_group_rule" "allow_rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = [var.allowed_cidr]
  security_group_id = var.security_group_id
}

