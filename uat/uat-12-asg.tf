#DEPRICATED LAUNCH CONFIGURATIONS#

# Create UAT APP Launch Configuration
#resource "aws_launch_configuration" "UAT-APP-LC" {
#  name = "UAT BCE Application Launch Configuration"
#  image_id               = var.application_ami_uat
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
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

# Create UAT MAP Launch Configuration
#resource "aws_launch_configuration" "UAT-MAP-LC" {
#  name = "UAT BCE Mapping Launch Configuration"
#  image_id               = var.mapping_ami_uat
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
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

# Create UAT APP Temporary Launch Configuration
#resource "aws_launch_configuration" "UAT-APP-LC-TEMP" {
#  name = "UAT BCE Temporary Application Launch Configuration"
#  image_id               = var.application_ami_uat_temp
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
#
#  lifecycle {
#    create_before_destroy = false
#  }
#}

# Create UAT MAP Temporary Launch Configuration
#resource "aws_launch_configuration" "UAT-MAP-LC-TEMP" {
#  name = "UAT BCE Temporary Mapping Launch Configuration"
#  image_id               = var.mapping_ami_uat_temp
#  instance_type          = "t3.medium"
#  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
#  security_groups        = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
#  key_name               = var.key_pair
#  enable_monitoring = true
#  metadata_options {
#  http_endpoint = "enabled"
#  http_tokens = "required"
#  }
# 
#  lifecycle {
#    create_before_destroy = false
#  }
#}

#NEW LAUNCH CONFIGURATIONS#

# Create UAT APP BLUE Launch Configuration
resource "aws_launch_configuration" "UAT-APP-LC-BLUE" {
  name = "UAT BCE BLUE Application Launch Configuration"
  image_id               = var.application_ami_uat_blue
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
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

# Create UAT MAP BLUE Launch Configuration
resource "aws_launch_configuration" "UAT-MAP-LC-BLUE" {
  name = "UAT BCE BLUE Mapping Launch Configuration"
  image_id               = var.mapping_ami_uat_blue
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
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

# Create UAT APP GREEN Launch Configuration
resource "aws_launch_configuration" "UAT-APP-LC-GREEN" {
  name = "UAT BCE GREEN Application Launch Configuration"
  image_id               = var.application_ami_uat_green
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.UAT-EC2-APP-SG.id}"]
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

# Create UAT MAP GREEN Launch Configuration
resource "aws_launch_configuration" "UAT-MAP-LC-GREEN" {
  name = "UAT BCE GREEN Mapping Launch Configuration"
  image_id               = var.mapping_ami_uat_green
  instance_type          = "t3.medium"
  iam_instance_profile = "${aws_iam_instance_profile.uat-ec2-cloudwatch.name}"
  security_groups        = ["${aws_security_group.UAT-EC2-MAP-SG.id}"]
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

# Create UAT APP AutoScaling Group
resource "aws_autoscaling_group" "UAT-APP-ASG" {
  count = "1"
  name = "UAT Application Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.UAT-APP-LC-GREEN.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.uat-private.*.id
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
  target_group_arns = ["${aws_lb_target_group.UAT-BCE-APP-TG.arn}", "${aws_lb_target_group.UAT-BCS-APP-TG.arn}", "${aws_lb_target_group.UAT-BCW-APP-TG.arn}", "${aws_lb_target_group.UAT-CFFG-APP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "UAT-EC2-APPLICATION${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create UAT MAP AutoScaling Group
resource "aws_autoscaling_group" "UAT-MAP-ASG" {
  count = "1"
  name = "UAT Mapping Auto Scale Group"
  launch_configuration = "${aws_launch_configuration.UAT-MAP-LC-GREEN.id}"
  # availability_zones = var.availability_zones
  vpc_zone_identifier = aws_subnet.uat-private.*.id
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
  target_group_arns = ["${aws_lb_target_group.UAT-BCE-MAP-TG.arn}", "${aws_lb_target_group.UAT-BCS-MAP-TG.arn}", "${aws_lb_target_group.UAT-BCW-MAP-TG.arn}", "${aws_lb_target_group.UAT-CFFG-MAP-TG.arn}"]
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "UAT-EC2-MAPPING${count.index + 1}"
    propagate_at_launch = true
  }
  tag {
    key = "Inspector"
    value = "ON"
    propagate_at_launch = true
  }
}

# Create UAT APP AutoScaling Policies
resource "aws_autoscaling_policy" "uat-app-scale-up" {
    count = "1"
    name = "uat-app-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.UAT-APP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "uat-app-scale-down" {
    count = "1"
    name = "uat-app-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.UAT-APP-ASG[count.index].name}"
}

# Create UAT MAP AutoScaling Policies
resource "aws_autoscaling_policy" "uat-map-scale-up" {
    count = "1"
    name = "uat-map-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.UAT-MAP-ASG[count.index].name}"
}

resource "aws_autoscaling_policy" "uat-map-scale-down" {
    count = "1"
    name = "uat-map-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 60
    autoscaling_group_name = "${aws_autoscaling_group.UAT-MAP-ASG[count.index].name}"
}

