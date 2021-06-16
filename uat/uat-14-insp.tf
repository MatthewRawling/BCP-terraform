# Inspector setup

resource "aws_inspector_resource_group" "uat-inspector" {
  tags = {
    Inspector = "ON"
  }
}
 
resource "aws_inspector_assessment_target" "uat-target" {
  name = "UAT Assessment Target"
  resource_group_arn = aws_inspector_resource_group.uat-inspector.arn
}
 
resource "aws_inspector_assessment_template" "uat-template" {
  name = "UAT Assessment Template"
  target_arn = aws_inspector_assessment_target.uat-target.arn
  duration = 3600
 
  rules_package_arns = [
    "arn:aws:inspector:eu-west-2:146838936955:rulespackage/0-kZGCqcE1", 
#    "arn:aws:inspector:eu-west-2:146838936955:rulespackage/0-IeCjwf1W", 
    "arn:aws:inspector:eu-west-2:146838936955:rulespackage/0-AizSYyNq", 
    "arn:aws:inspector:eu-west-2:146838936955:rulespackage/0-XApUiSaP", 
  ]
}
 
# Create assessment runs

data "aws_iam_policy_document" "uat_inspector_event_role_policy" {
  statement {
    sid = "StartAssessment"
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "uat_inspector_event_role" {
  name  = "uat-inspector-event-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "uat_inspector_event" {
  name   = "uat-inspector-event-policy"
  role   = aws_iam_role.uat_inspector_event_role.id
  policy = data.aws_iam_policy_document.uat_inspector_event_role_policy.json
}

resource "aws_cloudwatch_event_rule" "uat-inspector" {
  name        = "uat-scheduled-inspector-assessment"
  description = "Scheduled Inspector Assessment for ${aws_inspector_assessment_template.uat-template.arn}"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "uat-inspect" {
  rule      = aws_cloudwatch_event_rule.uat-inspector.name
  target_id = "Amazon_Inspector_Assess"
  arn       = aws_inspector_assessment_template.uat-template.arn
  role_arn  = aws_iam_role.uat_inspector_event_role.arn
}
