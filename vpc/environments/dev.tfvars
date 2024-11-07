# Generic Variables
region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_hostnames = true
enable_dns_support = true
tags={
    "Name" = "vpc-infra-prov"
    "Environment"   =   "dev"
}