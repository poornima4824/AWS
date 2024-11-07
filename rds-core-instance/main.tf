
resource "aws_security_group" "rds_security_group" {
  name        = var.name
  description = "security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = var.tags
}

resource "aws_db_subnet_group" "mysql_db_subnet_group" {
  name       = var.name_subnet
  subnet_ids = var.subnet_ids  # Ensure these subnets are in different AZs
  tags       = var.tags
}


resource "aws_db_instance" "this" {
  count                   = var.create_instance ? 1 : 0
  identifier              = var.project_name
  engine                  = var.engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_cluster_instance_class
  allocated_storage       = var.storage
  username                = var.master_username
  password                = var.master_password
  db_subnet_group_name    = aws_db_subnet_group.mysql_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_security_group.id]
  apply_immediately       = var.apply_immediately
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = var.storage_encrypted
  backup_retention_period = var.backup_retention_period
  license_model           = var.license_model
  multi_az                = var.multi_az
  tags                    = var.project_tags
}