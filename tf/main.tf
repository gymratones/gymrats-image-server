terraform {
  required_providers {
    railway = {
      source = "terraform-community-providers/railway"
      version = "0.4.4"
    }
  }
}
provider "railway" {
  token = var.railway_token
}

resource "railway_project" "gymrats_image_server_project" {
  name                = "gymrats"
  default_environment = {
    name = "staging"
  }
}

resource "railway_service" "gymrats_image_server_service" {
  name       = "gymrats.service.test"
  project_id = railway_project.gymrats_image_server_project.id
}

# resource "railway_variable" "bucket_name" {
#   service_id = railway_service.flask_api.id
#   name       = "BUCKET_NAME"
#   value      = var.bucket_name
# }

resource "railway_deployment_trigger" "gymrats_image_server_deployment_trigger" {
  repository     = var.github_repository
  branch         = var.branch_name
  check_suites   = true
  environment_id = railway_project.gymrats_image_server_project.default_environment.id
  service_id     = railway_service.gymrats_image_server_service.id
}