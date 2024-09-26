terraform {
  required_providers {
    railway = {
      source = "terraform-community-providers/railway"
      version = "0.4.4"
    }
  }
}
provider "railway" {
  token = "0a9b9e96-87d7-4fa9-87ff-d60f49242363"
  # RAILWAY_TOKEN = <token_from_github>
}

resource "railway_project" "gymrats_image_server_project" {
  name                = "gymrats"
  default_environment = {
    name = "staging"
  }
}

# resource "railway_environment" "gymrats_image_server_environment" {
#   name       = "staging"
#   project_id = railway_project.gymrats_image_server_project.id
# }

resource "railway_service" "gymrats_image_server_service" {
  name       = "gymrats.service.test"
  project_id = railway_project.gymrats_image_server_project.id
}

# resource "railway_variable" "bucket_name" {
#   service_id = railway_service.flask_api.id
#   name       = "BUCKET_NAME"
#   value      = var.bucket_name
# }

# resource "railway_deployment" "flask_api" {
#   service_id = railway_service.flask_api.id
#   triggers = {
#     code = filesha256("${path.module}/../../../app.py")
#   }
# }