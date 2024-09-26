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

resource "railway_variable" "storage_mode" {
  name            = "STORAGE_MODE"
  value           = var.storage_mode
  environment_id  = railway_project.gymrats_image_server_project.default_environment.id
  service_id      = railway_service.gymrats_image_server_service.id
}

resource "railway_variable" "b2_bucket_name" {
  name            = "B2_BUCKET_NAME"
  value           = var.b2_bucket_name
  environment_id  = railway_project.gymrats_image_server_project.default_environment.id
  service_id      = railway_service.gymrats_image_server_service.id
}

resource "railway_variable" "b2_key_id" {
  name            = "B2_KEY_ID"
  value           = var.b2_key_id
  environment_id  = railway_project.gymrats_image_server_project.default_environment.id
  service_id      = railway_service.gymrats_image_server_service.id
}

resource "railway_variable" "b2_application_key" {
  name            = "B2_APPLICATION_KEY"
  value           = var.b2_application_key
  environment_id  = railway_project.gymrats_image_server_project.default_environment.id
  service_id      = railway_service.gymrats_image_server_service.id
}

resource "railway_deployment_trigger" "gymrats_image_server_deployment_trigger" {
  repository     = var.github_repository
  branch         = var.branch_name
  check_suites   = true
  environment_id = railway_project.gymrats_image_server_project.default_environment.id
  service_id     = railway_service.gymrats_image_server_service.id
}