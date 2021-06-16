resource "aws_iam_role" "uat-bcp-rep" {
  name = "uat-bcp-rep"

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


resource "aws_iam_role_policy" "uat-bcp-rep-pol" {
  name = "uat-bcp-rep-pol"
  role = aws_iam_role.uat-bcp-rep.id

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
                "arn:aws:s3:::uat-bce-test",
                "arn:aws:s3:::uat-bce-test/*",
                "arn:aws:s3:::uat-bce-logs",
                "arn:aws:s3:::uat-bce-logs/*",
                "arn:aws:s3:::uat-bcs-logs",
                "arn:aws:s3:::uat-bcs-logs/*",
                "arn:aws:s3:::uat-bcw-logs",
                "arn:aws:s3:::uat-bcw-logs/*",
                "arn:aws:s3:::uat-cffg-logs",
                "arn:aws:s3:::uat-cffg-logs/*",
                "arn:aws:s3:::bcp-uat-cloudtrail",
                "arn:aws:s3:::bcp-uat-cloudtrail/*",
                "arn:aws:s3:::uat-bcp-cloudwatch",
                "arn:aws:s3:::uat-bcp-cloudwatch/*"

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
                        "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
                    ]
                }
            },
            "Resource": [
                "arn:aws:s3:::uat-bce-test-co/*",
                "arn:aws:s3:::uat-bce-logs-co/*",
                "arn:aws:s3:::uat-bcs-logs-co/*",
                "arn:aws:s3:::uat-bcw-logs-co/*",
                "arn:aws:s3:::uat-cffg-logs-co/*",
                "arn:aws:s3:::bcp-uat-cloudtrail-co/*",
                "arn:aws:s3:::uat-bcp-cloudwatch-co/*"
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
                        "arn:aws:s3:::uat-bce-test/*",
                        "arn:aws:s3:::uat-bce-logs/*",
                        "arn:aws:s3:::uat-bcs-logs/*",
                        "arn:aws:s3:::uat-bcw-logs/*",
                        "arn:aws:s3:::uat-cffg-logs/*",
                        "arn:aws:s3:::bcp-uat-cloudtrail/*",
                        "arn:aws:s3:::uat-bcp-cloudwatch/*"
                    ]
                }
            },
            "Resource": [
                "arn:aws:kms:eu-west-2:975971611990:key/a15d7fa2-542c-4d13-a27c-93ece87e0aba"
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
                        "arn:aws:s3:::uat-bce-test-co/*",
                        "arn:aws:s3:::uat-bce-logs-co/*",
                        "arn:aws:s3:::uat-bcs-logs-co/*",
                        "arn:aws:s3:::uat-bcw-logs-co/*",
                        "arn:aws:s3:::uat-cffg-logs-co/*",
                        "arn:aws:s3:::bcp-uat-cloudtrail/*",
                        "arn:aws:s3:::uat-bcp-cloudwatch/*"
                    ]
                }
            },
            "Resource": [
                "arn:aws:kms:eu-west-2:181623394163:key/197bbe36-b994-4665-97f8-87e58fdb8836"
            ]
        }
    ]
})
}

