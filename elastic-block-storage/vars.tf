variable "name" {
  type = string
  description = "name of ebs volume"
}

variable "availability_zone" {
  type = string
  description = "availability zone of ebs volume"
}

variable "kms_key_id" {
  type = string
  description = "kms key id of ebs volume"
}

variable "encrypted" {
  type = bool
  description = "encrypted ebs volume"
}

variable "iops" {
  type = number
  description = "iops of ebs volume"
}
variable "volume_size" {
  type = number
  description = "volume size of ebs volume"
}

variable "volume_type" {
  type = string
  description = "volume type of ebs volume"
}

variable "tags" {
  type = map(string)
  description = "tags for ebs volume"
}