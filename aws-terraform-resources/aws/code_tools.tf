module "code_tools" {
  source = "./code_tools"
  
  repository_name    = "my-repository"
  deploy_app_name    = "my-app"
  build_project_name = "my-project"
  commit_repo_name   = "my-repo"
}
