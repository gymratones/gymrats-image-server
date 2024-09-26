resource "railway_project" "flask_api" {
  name = "gymrats-terraform-test-project"
}

resource "railway_service" "flask_api" {
  project_id = railway_project.flask_api.id
  name       = "gymrats-terraform-test-api-service"
}

resource "railway_variable" "bucket_name" {
  service_id = railway_service.flask_api.id
  name       = "BUCKET_NAME"
  value      = var.bucket_name
}

# resource "railway_deployment" "flask_api" {
#   service_id = railway_service.flask_api.id
#   triggers = {
#     code = filesha256("${path.module}/../../../app.py")
#   }
# }