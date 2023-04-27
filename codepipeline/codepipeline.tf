
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.name}-code-pipeline"
  role_arn = module.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.source_connection_arn
        FullRepositoryId = var.source_FullRepositoryId
        BranchName       = var.source_branch_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project.name
        EnvironmentVariables = jsonencode([
          {
            name  = "AWS_ACCOUNT_ID"
            value = data.aws_caller_identity.current.account_id
            type  = "PLAINTEXT"
          },
          {
            name  = "AWS_REGION"
            value = data.aws_region.current.id
            type  = "PLAINTEXT"
          },
          {
            name  = "IMAGE_REPO_NAME"
            value = var.image_repo_name
            type  = "PLAINTEXT"
          },

        ])
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "ClusterName"       = var.ecs_cluster_name
        "ServiceName"       = var.ecs_service_name
        "FileName"          = "imagedefinitions.json"
        "DeploymentTimeout" = "15"
      }
      input_artifacts = [
        "build_output"
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "ECS"
      run_order        = 1
      version          = "1"
    }
  }

  tags = merge(
    {
      Name = "${var.name}-code-pipeline"
    },
    var.tags
  )
}

resource "aws_codebuild_project" "codebuild_project" {
  name           = var.codebuild_project_name
  description    = var.codebuild_project_description
  build_timeout  = var.codebuild_build_timeout
  queued_timeout = var.codebuild_queued_timeout
  service_role   = module.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  #cache {
  # type     = "S3"
  #location = aws_s3_bucket.example.bucket
  #}

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = var.codebuild_image
    type                        = var.codebuild_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.codebuild_privileged_mode

  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_cloudwatch_logs_group_name != null ? var.codebuild_cloudwatch_logs_group_name : var.name
      status      = var.codebuild_cloudwatch_logs_status
      stream_name = var.codebuild_cloudwatch_logs_stream_name
    }

  }

  source {
    type     = var.codebuild_source_type
    location = var.codebuild_source_location
    #git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = var.codebuild_fetch_submodules
    }
  }

  source_version = var.codebuild_source_version

  tags = merge(
    {
      Name = var.codebuild_project_name
    },
    var.tags
  )
}

# Create codebuild role

module "codebuild_role" {
  source = "./iam/roles/codebuild"
  name   = var.name
  tags   = var.tags
}

# Create code pipeline  role

module "codepipeline_role" {
  source = "./iam/roles/codepipeline"
  name   = var.name
  tags   = var.tags
}

# Create s3 bucket

module "s3_bucket" {
  source = "../s3"

  name             = var.s3_bucket_name
  key              = var.s3_codepipeline_key
  s3_force_destroy = true

  tags = var.tags
}