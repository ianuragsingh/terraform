#---------- Example of assumable iam-role with principal -----------

module "assumable_iam_role" {
  source = "../iam-role"

  role_name               = "test-assumable-role"
  role_description        = "MLOps team created this role for testing"
  principals_service_name = "ec2"
  aws_managed_policy_arns = var.aws_managed_policy_arns
}