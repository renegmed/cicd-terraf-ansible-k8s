resource "aws_iam_role" "k8s-role" {
  name               = "k8s-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "k8s-role" {
  name = "k8s-role"
  role = aws_iam_role.k8s-role.name
}

resource "aws_iam_role_policy" "admin-policy" {
  name = "k8s-admin-role-policy"
  role = aws_iam_role.k8s-role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

# Need to limit to 
#   AmazonEC2FullAccess 
#   AmazonS3FullAccess 
#   AmazonRoute53FullAccess
#   IAMFullAccess
