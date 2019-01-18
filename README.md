# Terraform VPC module

Simple module to create a VPC, some public subnets, and a couple of other
supporting resources.

Usage:

```
provider "aws" {
  region = "us-east-1"
}

module "myvpc" {
  source        = "github.com/mivok/terraform-vpc-module"
  name          = "myvpc"
  vpc_cidr      = "172.16.0.0/16"
  subnet_count  = 3
}
```

## Notes

The IP range of the VPC is split as equally as possible between the number of
subnets. If the number of subnets isn't a power of 2, then there will be a gap
at the top of the address space.

The number of subnets should be less than or equal to the number of
availability zones in a region. It's specified manually rather than
automatically calculated by querying the number of availability zones in a
region to guard against unexpected changes should a new availability zone be
created by Amazon.

All created subnets are 'public' subnets, where instances have public IPs
assigned to them, and route out directly through an internet gateway. No
private subnets nor NAT gateways are created.
