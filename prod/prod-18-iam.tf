resource "aws_iam_role" "prod-bcp-rep" {
  name = "prod-bcp-rep"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy" "prod-bcp-rep-pol" {
  name = "prod-bcp-rep-pol"
  role = aws_iam_role.prod-bcp-rep.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListBucket",
                "s3:GetReplicationConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionTagging",
                "s3:GetObjectRetention",
                "s3:GetObjectLegalHold"
            ],
            "Effect": "Allow",
            "Resource": [
#                "arn:aws:s3:::prod-bce-test",
#                "arn:aws:s3:::prod-bce-test/*",
                "arn:aws:s3:::prod-bce-logs",
                "arn:aws:s3:::prod-bce-logs/*",
                "arn:aws:s3:::prod-bcs-logs",
                "arn:aws:s3:::prod-bcs-logs/*",
                "arn:aws:s3:::prod-bcw-logs",
                "arn:aws:s3:::prod-bcw-logs/*",
                "arn:aws:s3:::prod-cffg-logs",
                "arn:aws:s3:::prod-cffg-logs/*",
                "arn:aws:s3:::bcp-prod-cloudtrail",
                "arn:aws:s3:::bcp-prod-cloudtrail/*",
                "arn:aws:s3:::prod-bcp-cloudwatch",
                "arn:aws:s3:::prod-bcp-cloudwatch/*"

            ]
        },
        {
            "Action": [
                "s3:ReplicateObject",
                "s3:ReplicateDelete",
                "s3:ReplicateTags",
                "s3:GetObjectVersionTagging",
                "s3:ObjectOwnerOverrideToBucketOwner"
            ],
            "Effect": "Allow",
            "Condition": {
                "StringLikeIfExists": {
                    "s3:x-amz-server-side-encryption": [
                        "aws:kms",
                        "AES256"
                    ],
                    "s3:x-amz-server-side-encryption-aws-kms-key-id": [
                        "arn:aws:kms:eu-west-2:181623394163:key/c2a60189-801b-41f9-953e-ec3efcffc819"
                    ]
                }
            },
            "Resource": [
                "arn:aws:s3:::prod-bce-test-co/*",
                "arn:aws:s3:::prod-bce-logs-co/*",
                "arn:aws:s3:::prod-bcs-logs-co/*",
                "arn:aws:s3:::prod-bcw-logs-co/*",
                "arn:aws:s3:::prod-cffg-logs-co/*",
                "arn:aws:s3:::bcp-prod-cloudtrail-co/*",
                "arn:aws:s3:::prod-bcp-cloudwatch-co/*"
            ]
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Effect": "Allow",
            "Condition": {
                "StringLike": {
                    "kms:ViaService": "s3.eu-west-2.amazonaws.com",
                    "kms:EncryptionContext:aws:s3:arn": [
#                        "arn:aws:s3:::prod-bce-test/*",
                        "arn:aws:s3:::prod-bce-logs/*",
                        "arn:aws:s3:::prod-bcs-logs/*",
                        "arn:aws:s3:::prod-bcw-logs/*",
                        "arn:aws:s3:::prod-cffg-logs/*",
                        "arn:aws:s3:::bcp-prod-cloudtrail/*",
                        "arn:aws:s3:::prod-bcp-cloudwatch/*"
                    ]
                }
            },
            "Resource": [
                "arn:aws:kms:eu-west-2:975971611990:key/1de91818-0a1a-4d10-af80-ab0c0076226a"
            ]
        },
        {
            "Action": [
                "kms:Encrypt"
            ],
            "Effect": "Allow",
            "Condition": {
                "StringLike": {
                    "kms:ViaService": [
                        "s3.eu-west-2.amazonaws.com"
                    ],
                    "kms:EncryptionContext:aws:s3:arn": [
#                        "arn:aws:s3:::prod-bce-test-co/*",
                        "arn:aws:s3:::prod-bce-logs-co/*",
                        "arn:aws:s3:::prod-bcs-logs-co/*",
                        "arn:aws:s3:::prod-bcw-logs-co/*",
                        "arn:aws:s3:::prod-cffg-logs-co/*",
                        "arn:aws:s3:::bcp-prod-cloudtrail/*",
                        "arn:aws:s3:::prod-bcp-cloudwatch/*"
                    ]
                }
            },
            "Resource": [
                "arn:aws:kms:eu-west-2:181623394163:key/c2a60189-801b-41f9-953e-ec3efcffc819"
            ]
        }
    ]
})
}

