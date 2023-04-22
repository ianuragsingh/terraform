#----------------------IAM Role-------------------------
resource "aws_iam_role" "role" {
  name        = var.role_name
  description = var.role_description

  path                  = var.iam_role_path
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy_document.json
  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["${var.principals_service_name}.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count      = length(var.aws_managed_policy_arns) == 0 ? 0 : length(var.aws_managed_policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = var.aws_managed_policy_arns[count.index]
}
