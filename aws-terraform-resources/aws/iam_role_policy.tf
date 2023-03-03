// iam_role_policy.tf

module "iam_role_policy" {
  source = "./modules/iam_role_policy"

  name         = "example_role"
  policy_name  = "example_policy"
  policy       = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::example-bucket/*"
    }
  ]
}
EOF
}
