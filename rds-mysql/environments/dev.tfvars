project_name = "rds-dac-mysql"
# Tags for the RDS project
project_tags = {
  Name = "rds-mysql-sg"
}
ingress_rules = [
  {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
name_subnet="db-subnet-groups-mysql-dev"
subnet_ids = ["subnet-03bfb0c575866eb1e","subnet-065684815f2dd01d8"]
db_cluster_instance_class = "db.m5d.large"
vpc_id = "vpc-0a6cf673aa37f41b2"
vpc_spoke_public_subnet_cidrs = ["10.0.0.0/20", "10.0.96.0/20", "10.0.48.0/20"]
region = "ap-southeast-1"
engine = "mysql"
db_engine_version = "8.0"
storage_encrypted = false
master_username = "root"
master_password = "arjun123"
monitoring_interval = 60
apply_immediately = true
skip_final_snapshot = true
scaling_configuration = {
  auto_pause               = true
  min_capacity             = 2
  max_capacity             = 16
  seconds_until_auto_pause = 300
  timeout_action           = "ForceApplyCapacityChange"
}
allow_major_version_upgrade = true
auto_minor_version_upgrade = false
backup_retention_period = 7
copy_tags_to_snapshot = true
database_name = "mysql_database"
delete_automated_backups = true
deletion_protection = false
final_snapshot_identifier = "mysql-final-snapshot"
performance_insights_enabled = true
license_model = "general-public-license"
multi_az = false
