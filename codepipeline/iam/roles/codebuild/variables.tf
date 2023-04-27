variable "name" {
  description = "Codebuild role name"
  type        = string
  default     = null
}

variable "tags" {
  description = "AWS Resource tags"
  type        = map(string)
  default     = null
}