terraform {
  required_providers {
    railway = {
      source = "terraform-community-providers/railway"
    }
  }
}

provider "railway" {
  token = "0a9b9e96-87d7-4fa9-87ff-d60f49242363"
}

# module "railway_deployment" {
#   source = "./modules/railway"
  
#   bucket_name = var.BUCKET_NAME
# }

# resource "railway_project" "flask_api" {
#   name = "gymrats-terraform-test-project"
# }

# resource "railway_service" "flask_api" {
#   project_id = railway_project.flask_api.id
#   name       = "gymrats-terraform-test-api-service"
# }

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