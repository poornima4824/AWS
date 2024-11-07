#Ec2 Instance - Public
ec2_type                              = "t2.medium"
key_name                              = "linux-public-key"
role_name                             = "ec2-s3"
profile_name                          = "ec2profile"
policy_name                           = "ec2_S3policy"
security_group                        = "instance-sg1"
ec2_amiid                             = "ami-05bf0125f616dc488"
vpc_id                                = "vpc-0a6cf673aa37f41b2"
public_subnet                         = "subnet-037c13388fd4ad82a"
region                                = "ap-southeast-1"
windows_associate_public_ip_address   = true
create_vpc_endpoint                   = false
create_aws_iam_instance_profile       = false
create_aws_iam_role                   = false
create_aws_iam_role_policy_attachment = false
create_aws_iam_policy                 = false
tags = {
  Name        = "dac-ec2-linux-infra-prov-public"
  created_for = "Linux-Public"
  created_by  = "Terraform"
}
security_group_tags = {
  Environment = "dev"
}