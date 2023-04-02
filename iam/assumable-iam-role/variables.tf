variable "name" {
  description = "IAM role name"
  type        = string
}

variable "description" {
  description = "IAM Role description"
  type        = string
}

variable "principals_service_name" {
  description = "Proncipal Service name to attach/assume with role"
  type        = string
}

variable "managed_policy_arns" {
  description = "AWS managed Policies arn"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Resource tags"
  type        = map(any)
  default     = {}
}