# The bastion instance lives in the first private subnet
resource "aws_instance" "bastion" {
  ami               = var.ami_id
  availability_zone = reverse(var.availability_zones)[0]
  ebs_optimized     = true
  instance_type     = var.bastion_flavor
  monitoring        = false
  key_name          = var.ssh_key
  subnet_id         = reverse(aws_subnet.private)[0].id

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 500
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  lifecycle {
    ignore_changes = [
      # AWS updates these dynamically, do not interfere.
      tags["ServiceOwner"],
      tags_all["ServiceOwner"],
      root_block_device["tags"]
    ]
  }

  user_data = templatefile(
    "${path.module}/setup.sh.tftpl", {
      hostname          = "${var.bastion_hostname}.${var.domain}"
      ec2_user_password = var.instance_password
    }
  )

  tags = {
    Name = "bastion.${var.domain}"
    Role = "bastion"
  }
}
