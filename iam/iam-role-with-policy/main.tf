#-----------------IAM Role with policy document------------------
resource "aws_iam_role" "role" {
  name        = var.role_name
  description = var.role_description

  path                  = var.iam_role_path
  assume_role_policy    = var.assume_role_policy_document
  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = var.iam_policy_document
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role_policy_attachment" "iam_role_managed_policy_attachment" {
  count      = length(var.aws_managed_policy_arns) == 0 ? 0 : length(var.aws_managed_policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = var.aws_managed_policy_arns[count.index]
}
