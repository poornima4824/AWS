#-----------------------------------------------------------------------------------------
###### DATA BLOCK FOR EXISTING VPC ######
#-----------------------------------------------------------------------------------------
data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}


module "rds_instance" {
  source                    = "../rds-core-instance/"
  count                     = substr(var.engine, 0, length("mysql")) == "mysql" ? 1 : 0
  project_name              = var.project_name
  engine                    = var.engine
  db_engine_version         = var.db_engine_version
  db_cluster_instance_class = var.db_cluster_instance_class
  storage                   = var.storage
  master_username           = var.master_username
  master_password           = var.master_password
  name_subnet               = var.name_subnet
  subnet_ids                = var.subnet_ids
  ingress_rules             = var.ingress_rules
  apply_immediately         = var.apply_immediately
  skip_final_snapshot       = var.skip_final_snapshot
  storage_encrypted         = var.storage_encrypted
  backup_retention_period   = var.backup_retention_period
  license_model             = var.license_model
  multi_az                  = var.multi_az
  tags                      = var.project_tags
  vpc_id                    = var.vpc_id
  
}
