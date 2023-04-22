
#---------- Example of assumable iam-role with policy document -----------

module "iam_role_with_policy" {
  source = "../iam-role-with-policy"

  role_name        = "mlops-test-iam-role-with-policy"
  role_description = "MLOps team created this role for testing"

  policy_name        = "mlops-test-iam-role-policy"
  policy_description = "MLOps team created this policy for testing"

  assume_role_policy_document = data.aws_iam_policy_document.assume_role_policy_document.json
  iam_policy_document         = data.aws_iam_policy_document.iam_policy_document.json
  aws_managed_policy_arns     = var.aws_managed_policy_arns
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}