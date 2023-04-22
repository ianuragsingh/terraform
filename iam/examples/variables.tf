variable "project_name" {
  description = "Deployer container registory"
  type        = string
  default     = "mlops-test"
}

variable "env" {
  description = "environemnt name"
  type        = string
  default     = "qa"
}

variable "aws_managed_policy_arns" {
  description = "AWS managed Policies arn"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess",
    "arn:aws:iam::aws:policy/AmazonDocDBFullAccess"
  ]
}