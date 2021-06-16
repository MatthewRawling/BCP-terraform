# Get latest snapshot from production DB

data "aws_db_snapshot" "uat-snap" {
    most_recent = true
    db_instance_identifier = var.rds_instance_uat 
}

# Create new staging DB

resource "aws_db_instance" "uat-bcp-db" {
  instance_class       = "db.m5.large"
  identifier           = "uat-bcp-db"
  storage_encrypted    = "true"
#  username             = "xxx"
#  password             = "xxx"
  db_subnet_group_name = aws_db_subnet_group.uat-rds-sub.id
  snapshot_identifier  = "${data.aws_db_snapshot.uat-snap.id}"
  lifecycle {
      ignore_changes = ["snapshot_identifier"]
    }
  vpc_security_group_ids = [aws_security_group.UAT-RDS-SG.id]
  skip_final_snapshot = true
}
