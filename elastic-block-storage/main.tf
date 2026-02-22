resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.availability_zone
  size             = var.volume_size
  type             = var.volume_type
  iops             = var.iops
  encrypted        = var.encrypted
  kms_key_id       = var.kms_key_id

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}