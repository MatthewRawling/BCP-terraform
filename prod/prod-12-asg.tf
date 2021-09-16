# Create PROD APP Launch Configuration
resource "aws_launch_configuration" "PROD-APP-LC" {
  name = "PROD BCE Application Launch Configuration"
  image_id               = var.application_ami_prod
  instance_type          = "m5a.large"
  iam_instance_profile = "${aws_iam_instance_profile.prod-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.PROD-EC2-APP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  lifecycle {
    create_before_destroy = false
  }
}

# Create PROD MAP Launch Configuration
resource "aws_launch_configuration" "PROD-MAP-LC" {
  name = "PROD BCE Mapping Launch Configuration"
  image_id               = var.mapping_ami_prod
  instance_type          = "c5a.4xlarge"
  iam_instance_profile = "${aws_iam_instance_profile.prod-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.PROD-EC2-MAP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  lifecycle {
    create_before_destroy = false
  }
}

# Create PROD APP Temporary Launch Configuration
resource "aws_launch_configuration" "PROD-APP-LC-TEMP" {
  name = "PROD BCE Temporary Application Launch Configuration"
  image_id               = var.application_ami_prod_temp
  instance_type          = "m5a.large"
  iam_instance_profile = "${aws_iam_instance_profile.prod-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.PROD-EC2-APP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  lifecycle {
    create_before_destroy = false
  }
}

# Create PROD MAP Temporary Launch Configuration
resource "aws_launch_configuration" "PROD-MAP-LC-TEMP" {
  name = "PROD BCE Temporary Mapping Launch Configuration"
  image_id               = var.mapping_ami_prod_temp
  instance_type          = "c5a.4xlarge"
  iam_instance_profile = "${aws_iam_instance_profile.prod-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.PROD-EC2-MAP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  lifecycle {
    create_before_destroy = false
  }
}

# Create PROD APP AutoScaling Group
resource "aws_autoscaling_group" "PROD-APP-ASG" {
  count = "1"
  name = "PROD Application Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.PROD-APP-LC-TEMP.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.prod-private.*.id
  min_size = 2
  max_size = 6
    enabled_metrics           = [
          "GroupAndWarmPoolDesiredCapacity",
          "GroupAndWarmPoolTotalCapacity",
          "GroupDesiredCapacity",
          "GroupInServiceCapacity",
          "GroupInServiceInstances",
          "GroupMaxSize",
          "GroupMinSize",
          "GroupPendingCapacity",
          "GroupPendingInstances",
          "GroupStandbyCapacity",
          "GroupStandbyInstances",
          "GroupTerminatingCapacity",
          "GroupTerminatingInstances",
          "GroupTotalCapacity",
          "GroupTotalInstances",
          "WarmPoolDesiredCapacity",
          "WarmPoolMinSize",
          "WarmPoolPendingCapacity",
          "WarmPoolTerminatingCapacity",
          "WarmPoolTotalCapacity",
          "WarmPoolWarmedCapacity",
        ]
  target_group_arns = ["${aws_lb_target_group.PROD-BCE-APP-TG.arn}", "${aws_lb_target_group.PROD-BCS-APP-TG.arn}", "${aws_lb_target_group.PROD-BCW-APP-TG.arn}", "${aws_lb_target_group.PROD-CFFG-APP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "PROD-EC2-APPLICATION${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create PROD MAP AutoScaling Group
resource "aws_autoscaling_group" "PROD-MAP-ASG" {
  count = "1"
  name = "PROD Mapping Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.PROD-MAP-LC-TEMP.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.prod-private.*.id
  min_size = 2
  max_size = 6
    enabled_metrics           = [
          "GroupAndWarmPoolDesiredCapacity",
          "GroupAndWarmPoolTotalCapacity",
          "GroupDesiredCapacity",
          "GroupInServiceCapacity",
          "GroupInServiceInstances",
          "GroupMaxSize",
          "GroupMinSize",
          "GroupPendingCapacity",
          "GroupPendingInstances",
          "GroupStandbyCapacity",
          "GroupStandbyInstances",
          "GroupTerminatingCapacity",
          "GroupTerminatingInstances",
          "GroupTotalCapacity",
          "GroupTotalInstances",
          "WarmPoolDesiredCapacity",
          "WarmPoolMinSize",
          "WarmPoolPendingCapacity",
          "WarmPoolTerminatingCapacity",
          "WarmPoolTotalCapacity",
          "WarmPoolWarmedCapacity",
        ]
  target_group_arns = ["${aws_lb_target_group.PROD-BCE-MAP-TG.arn}", "${aws_lb_target_group.PROD-BCS-MAP-TG.arn}", "${aws_lb_target_group.PROD-BCW-MAP-TG.arn}", "${aws_lb_target_group.PROD-CFFG-MAP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "PROD-EC2-MAPPING${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create PROD APP AutoScaling Policies
resource "aws_autoscaling_policy" "prod-app-scale-up" {
    count = "1"
    name = "prod-app-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.PROD-APP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "prod-app-scale-down" {
    count = "1"
    name = "prod-app-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.PROD-APP-ASG[count.index].name}"
}

# Create PROD MAP AutoScaling Policies
resource "aws_autoscaling_policy" "prod-map-scale-up" {
    count = "1"
    name = "prod-map-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.PROD-MAP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "prod-map-scale-down" {
    count = "1"
    name = "prod-map-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.PROD-MAP-ASG[count.index].name}"
}

