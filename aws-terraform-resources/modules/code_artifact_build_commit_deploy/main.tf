# main.tf

variable "repository_name" {
  description = "The name of the CodeArtifact repository"
}

variable "deploy_app_name" {
  description = "The name of the CodeDeploy application"
}

variable "build_project_name" {
  description = "The name of the CodeBuild project"
}

variable "commit_repo_name" {
  description = "The name of the CodeCommit repository"
}

resource "aws_codeartifact_repository" "repository" {
  repository_name = var.repository_name
  description     = "Created by Terraform"
  upstreams       = []
}

resource "aws_codedeploy_app" "deploy_app" {
  name = var.deploy_app_name
}

resource "aws_codebuild_project" "build_project" {
  name = var.build_project_name

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type = "NO_SOURCE"
  }
}

resource "aws_codecommit_repository" "commit_repo" {
  repository_name = var.commit_repo_name
}
