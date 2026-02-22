# AWS EBS Volume Terraform Module

This Terraform module creates an AWS Elastic Block Store (EBS) volume with configurable parameters.

## Usage

```hcl
module "ebs_volume" {
  source = "./modules/elastic-block-storage"

  name         = "my-ebs-volume"
  volume_size  = 20
  volume_type  = "gp3"
  availability_zone = "us-west-2a"
  
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the EBS volume | `string` | n/a | yes |
| volume_size | The size of the drive in GiBs | `number` | n/a | yes |
| volume_type | The type of EBS volume | `string` | `"gp3"` | no |
| availability_zone | The AZ where the EBS volume will exist | `string` | n/a | yes |
| iops | The amount of IOPS to provision for the volume | `number` | `null` | no |
| encrypted | If true, the disk will be encrypted | `bool` | `true` | no |
| kms_key_id | The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume | `string` | `null` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| volume_id | The ID of the created EBS volume |
| volume_arn | The ARN of the EBS volume |
| volume_size | The size of the volume in GiBs |
| volume_encrypted | Whether the volume is encrypted |

## Notes

- This module creates a single EBS volume. For multiple volumes, call the module multiple times.
- The volume will be created in the specified availability zone.
- By default, volumes are encrypted using the default EBS encryption key if no KMS key is specified.
