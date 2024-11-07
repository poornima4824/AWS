resource "aws_instance" "ec2_instance" {
  ami                         = var.ec2_amiid
  instance_type               = var.ec2_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.selected.id
  vpc_security_group_ids      = [aws_security_group.asg_ec2.id]
  associate_public_ip_address = var.windows_associate_public_ip_address
  tags                        = var.tags
  depends_on                  = [aws_key_pair.aws_key]
}

resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key" {
  key_name   = var.key_name
  public_key = tls_private_key.tls.public_key_openssh
}

# Save Key Pair file 
resource "local_file" "ssh_key" {
  filename        = "${aws_key_pair.aws_key.key_name}.pem"
  content         = tls_private_key.tls.private_key_pem
  file_permission = "0400"
}
# creating Security group to allow port inbound
resource "aws_security_group" "asg_ec2" {
  name        = var.security_group
  description = "Security group for EC2"

  vpc_id = data.aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your desired source IP range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.security_group_tags
}

resource "aws_iam_role" "ec2_s3_access_role" {
  count              = var.create_aws_iam_role ? 1 : 0
  name               = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2profile" {
  count = var.create_aws_iam_instance_profile ? 1 : 0
  name  = var.profile_name
  role  = aws_iam_role.ec2_s3_access_role[0].name
}

resource "aws_iam_policy" "policy" {
  count       = var.create_aws_iam_policy ? 1 : 0
  name        = var.policy_name
  description = "Access to s3 policy from ec2"
  policy      = <<EOF
{
 "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": "s3:*",
           "Resource": "*"
       }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-attach" {
  count      = var.create_aws_iam_role_policy_attachment ? 1 : 0
  role       = aws_iam_role.ec2_s3_access_role[0].name
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_vpc_endpoint" "s3" {
  count        = var.create_vpc_endpoint ? 1 : 0
  vpc_id       = data.aws_vpc.my_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
}