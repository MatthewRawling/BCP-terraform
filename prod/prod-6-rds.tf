# Get latest snapshot from production DB

data "aws_db_snapshot" "prod-snap" {
    most_recent = true
    db_instance_identifier = var.rds_instance_prod 
}

# Create new staging DB

resource "aws_db_instance" "prod-bcp-db" {
  instance_class       = "db.m5.8xlarge"
  identifier           = "prod-bcp-db"
  storage_encrypted    = "true"
  multi_az             = "true"
#  username             = "xxx"
#  password             = "xxx"
  db_subnet_group_name = aws_db_subnet_group.prod-rds-sub.id
  snapshot_identifier  = "${data.aws_db_snapshot.prod-snap.id}"
  lifecycle {
      ignore_changes = ["snapshot_identifier"]
    }
  vpc_security_group_ids = [aws_security_group.PROD-RDS-SG.id]
  skip_final_snapshot = true
}
