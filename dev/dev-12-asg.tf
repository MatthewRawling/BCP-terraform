#OLD DEPRICATED LC's#

# Create DEV APP Launch Configuration
#resource "aws_launch_configuration" "DEV-APP-LC" {
#  name = "DEV BCE Application Launch Configuration"
#  image_id               = var.application_ami_dev
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
#  lifecycle {
#    create_before_destroy = false
#  }
#}

# Create DEV MAP Launch Configuration
#resource "aws_launch_configuration" "DEV-MAP-LC" {
#  name = "DEV BCE Mapping Launch Configuration"
#  image_id               = var.mapping_ami_dev
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.DEV-EC2-MAP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
#  lifecycle {
#    create_before_destroy = false
#  }
#}

# Create DEV APP Temporary Launch Configuration
#resource "aws_launch_configuration" "DEV-APP-LC-TEMP" {
#  name = "DEV BCE Temporary Application Launch Configuration"
#  image_id               = var.application_ami_dev_temp
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
#  lifecycle {
#    create_before_destroy = false
#  }
#}

# Create DEV MAP Temporary Launch Configuration
#resource "aws_launch_configuration" "DEV-MAP-LC-TEMP" {
#  name = "DEV BCE Temporary Mapping Launch Configuration"
#  image_id               = var.mapping_ami_dev_temp
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.DEV-EC2-MAP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
#  lifecycle {
#    create_before_destroy = false
#  }
#}

#NEW LC's#

# Create DEV APP BLUE Launch Configuration
resource "aws_launch_configuration" "DEV-APP-LC-BLUE" {
  name = "DEV BCE BLUE Application Launch Configuration"
  image_id               = var.application_ami_dev_blue
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  metadata_options {
  http_endpoint = "enabled"
  http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = false
  }
}

# Create DEV MAP BLUE Launch Configuration
resource "aws_launch_configuration" "DEV-MAP-LC-BLUE" {
  name = "DEV BCE BLUE Mapping Launch Configuration"
  image_id               = var.mapping_ami_dev_blue
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.DEV-EC2-MAP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  metadata_options {
  http_endpoint = "enabled"
  http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = false
  }
}

# Create DEV APP GREEN Launch Configuration
resource "aws_launch_configuration" "DEV-APP-LC-GREEN" {
  name = "DEV BCE GREEN Application Launch Configuration"
  image_id               = var.application_ami_dev_green
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.DEV-EC2-APP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  metadata_options {
  http_endpoint = "enabled"
  http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = false
  }
}

# Create DEV MAP GREEN Launch Configuration
resource "aws_launch_configuration" "DEV-MAP-LC-GREEN" {
  name = "DEV BCE GREEN Mapping Launch Configuration"
  image_id               = var.mapping_ami_dev_green
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.dev-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.DEV-EC2-MAP-SG.id}"]
  key_name               = var.key_pair
  enable_monitoring = true
  metadata_options {
  http_endpoint = "enabled"
  http_tokens = "required"
  }
  lifecycle {
    create_before_destroy = false
  }
}


# Create DEV APP AutoScaling Group
resource "aws_autoscaling_group" "DEV-APP-ASG" {
  count = "1"
  name = "DEV Application Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.DEV-APP-LC-BLUE.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.dev-private.*.id
  min_size = 1
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
  target_group_arns = ["${aws_lb_target_group.DEV-BCE-APP-TG.arn}", "${aws_lb_target_group.DEV-BCS-APP-TG.arn}", "${aws_lb_target_group.DEV-BCW-APP-TG.arn}", "${aws_lb_target_group.DEV-CFFG-APP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "DEV-EC2-APPLICATION${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create DEV MAP AutoScaling Group
resource "aws_autoscaling_group" "DEV-MAP-ASG" {
  count = "1"
  name = "DEV Mapping Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.DEV-MAP-LC-BLUE.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.dev-private.*.id
  min_size = 1
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
  target_group_arns = ["${aws_lb_target_group.DEV-BCE-MAP-TG.arn}", "${aws_lb_target_group.DEV-BCS-MAP-TG.arn}", "${aws_lb_target_group.DEV-BCW-MAP-TG.arn}", "${aws_lb_target_group.DEV-CFFG-MAP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "DEV-EC2-MAPPING${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create DEV APP AutoScaling Policies
resource "aws_autoscaling_policy" "dev-app-scale-up" {
    count = "1"
    name = "dev-app-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.DEV-APP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "dev-app-scale-down" {
    count = "1"
    name = "dev-app-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.DEV-APP-ASG[count.index].name}"
}

# Create DEV MAP AutoScaling Policies
resource "aws_autoscaling_policy" "dev-map-scale-up" {
    count = "1"
    name = "dev-map-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.DEV-MAP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "dev-map-scale-down" {
    count = "1"
    name = "dev-map-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.DEV-MAP-ASG[count.index].name}"
}

