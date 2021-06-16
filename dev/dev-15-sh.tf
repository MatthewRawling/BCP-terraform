# Subscribe the Account to Security Hub
 
resource "aws_securityhub_account" "dev-bcp" {}
 
# Subscribe to Security Hub Standards
 
# data "aws_region" "current" {}
 
resource "aws_securityhub_standards_subscription" "dev-bcp" {
  depends_on = [aws_securityhub_account.dev-bcp]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
}
