#-------------------------------------------------------------
#                       IAM Role
#-------------------------------------------------------------

resource "aws_iam_role" "role" {
  name        = var.name
  description = var.description

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["${var.principals_service_name}.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count      = length(var.managed_policy_arns) == 0 ? 0 : length(var.managed_policy_arn)
  role       = aws_iam_role.role.name
  policy_arn = var.managed_policy_arns[count.index]
}