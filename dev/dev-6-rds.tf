# Get latest snapshot from production DB

data "aws_db_snapshot" "dev-snap" {
    most_recent = true
    db_instance_identifier = var.rds_instance_dev 
}

# Create new staging DB

resource "aws_db_instance" "dev-bcp-db" {
  instance_class       = "db.t3.medium"
  identifier           = "dev-bcp-db"
  storage_encrypted    = "true"
#  username             = "xxx"
#  password             = "xxx"
  db_subnet_group_name = aws_db_subnet_group.dev-rds-sub.id
  snapshot_identifier  = "${data.aws_db_snapshot.dev-snap.id}"
  lifecycle {
      ignore_changes = ["snapshot_identifier"]
    }
  vpc_security_group_ids = [aws_security_group.DEV-RDS-SG.id]
  skip_final_snapshot = true
}
