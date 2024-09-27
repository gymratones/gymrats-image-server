terraform {
  cloud {
    organization = "gymrats"
    hostname = "app.terraform.io"
    workspaces {
      name = "gymrats-image-server"
      project = "gymrats"
    }
  }
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

locals {
  project_name = "img-${var.branch_name}-gymrats"
}

resource "railway_project" "gymrats_image_server_project" {
  name                = "${local.project_name}-project"
  default_environment = {
    name = "staging"
  }
}

resource "railway_service" "gymrats_image_server_service" {
  name       = "${local.project_name}-service-new"
  project_id = railway_project.gymrats_image_server_project.id
}

resource "railway_variable_collection" "gymrats_image_server_variable_collection" {
  environment_id = railway_project.gymrats_image_server_project.default_environment.id
  service_id     = railway_service.gymrats_image_server_service.id

  variables = [
    {
      name  = "STORAGE_MODE"
      value = var.storage_mode
    },
    {
      name  = "B2_BUCKET_NAME"
      value = var.b2_bucket_name
    },
    {
      name  = "B2_KEY_ID"
      value = var.b2_key_id
    },
    {
      name  = "B2_APPLICATION_KEY"
      value = var.b2_application_key
    }
  ]
}

resource "railway_deployment_trigger" "gymrats_image_server_deployment_trigger" {
  repository     = var.github_repository
  branch         = var.branch_name
  check_suites   = false
  environment_id = railway_project.gymrats_image_server_project.default_environment.id
  service_id     = railway_service.gymrats_image_server_service.id
}

# resource "railway_service_domain" "gymrats_image_server_service_domain" {
#   subdomain      = "${local.project_name}"
#   environment_id = railway_project.gymrats_image_server_project.default_environment.id
#   service_id     = railway_service.gymrats_image_server_service.id
# }