variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "root_block_device_type" {
  type = string
}

variable "root_block_device_size_in_gb" {
  type = number
}

variable "hostname" {
  type = string
}

variable "environment" {
  type = string
}

variable "secondary_block_device" {
  type = bool
}

variable "secondary_block_device_type" {
  type = string
}

variable "secondary_block_device_size_in_gb" {
  type = number
}

