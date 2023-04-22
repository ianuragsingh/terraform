variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "(Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false"
  type        = bool
  default     = false
}

variable "principals_service_name" {
  description = "Proncipal Service name to attach/assume with role"
  type        = string
}

variable "aws_managed_policy_arns" {
  description = "AWS managed Policies arn"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Resource tags"
  type        = map(any)
  default     = {}
}
