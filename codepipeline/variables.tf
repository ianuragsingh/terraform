#-------------------------------------------------------------
#                         Variables
#-------------------------------------------------------------

variable "name" {
  description = "Codepipeline name"
  type        = string
  default     = null
}

variable "codepipeline_role_arn" {
  description = "S3 bucket name for codepipeline artifact store"
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "S3 bucket name for codepipeline artifact store "
  type        = string
  default     = null
}

variable "s3_codepipeline_key" {
  description = "S3 folder name for codepipeline artifacts"
  type        = string
  default     = null
}

variable "source_connection_arn" {}

variable "source_FullRepositoryId" {}

variable "source_branch_name" {}

variable "codebuild_project_name" {
  type = string
}

variable "codebuild_project_description" {
  type = string
}

variable "codebuild_build_timeout" {
  default = 60
}

variable "codebuild_queued_timeout" {
  default = 480
}

variable "codebuild_compute_type" {
  description = <<EOF
    "Information about the compute resources the build project will use./n
    Valid values: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE,/n 
    BUILD_GENERAL1_2XLARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER./n
    When type is set to LINUX_GPU_CONTAINER, compute_type must be BUILD_GENERAL1_LARGE"
  EOF

  type    = string
  default = "BUILD_GENERAL1_MEDIUM"
}

variable "codebuild_image" {
  description = <<EOF
    "Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), 
    Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR 
    (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest"
EOF
  type        = string
}

variable "codebuild_type" {
  description = <<EOF
    "Type of build environment to use for related builds. Valid values: 
    LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER"
EOF
  type        = string
}

variable "codebuild_image_pull_credentials_type" {
  description = <<EOF
    "Type of credentials AWS CodeBuild uses to pull images in your build. Valid values: 
    CODEBUILD, SERVICE_ROLE. When you use a cross-account or private registry image, 
    you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CodeBuild credentials."
EOF
  type        = string
  default     = "CODEBUILD"
}

variable "codebuild_privileged_mode" {
  description = "Whether to enable running the Docker daemon inside a Docker container"
  type        = string
  default     = false
}

variable "codebuild_cloudwatch_logs_group_name" {
  description = "Group name of the logs in CloudWatch Logs."
  type        = string
  default     = null
}

variable "codebuild_cloudwatch_logs_status" {
  description = "Current status of logs in CloudWatch Logs for a build project. Valid values: ENABLED, DISABLED"
  type        = string
  default     = "ENABLED"
}

variable "codebuild_cloudwatch_logs_stream_name" {
  description = "Stream name of the logs in CloudWatch Logs."
  type        = string
  default     = "codebuild"
}

variable "codebuild_source_type" {

  description = <<EOF
    "Type of repository that contains the source code to be built. Valid values: 
    CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3, NO_SOURCE."
EOF
  type        = string

}

variable "codebuild_source_location" {
  description = "Location of the source code from git or s3."
  type        = string
}

variable "codebuild_fetch_submodules" {
  description = "Whether to fetch Git submodules for the AWS CodeBuild build project."
  type        = string
}

variable "codebuild_source_version" {
  description = "Whether to fetch Git submodules for the AWS CodeBuild build project."
  type        = string
}

variable "image_repo_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "tags" {
  description = "Additional of Resource Tags"
  type        = map(string)
  default     = null
}