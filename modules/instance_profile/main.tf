data "aws_iam_policy_document" "ec2-assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = var.instance_profile_name
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.role_name
  description        = "IAM role for instance profile"
  assume_role_policy = data.aws_iam_policy_document.ec2-assume.json
}

resource "aws_iam_role_policy_attachment" "ssm-instance-profile-policy" {
  count = var.attach_ssm_policy ? 1 : 0

  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "policy" {
  for_each = var.extra_policy_documents

  name   = each.key
  path   = "/"
  policy = each.value
}

resource "aws_iam_role_policy_attachment" "attachment" {
  for_each = var.extra_policy_documents

  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy[each.key].arn
}


resource "aws_iam_role_policy" "describe-instances" {
  count = var.attach_policy_describe_instances ? 1 : 0
  name  = "describe-instances"
  role  = aws_iam_role.role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "EC2InstanceConnect"
        Action = [
          "ec2:DescribeInstances"
        ],
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}