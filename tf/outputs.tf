# Output the project ID
output "project_id" {
  value       = railway_project.gymrats_image_server_project.id
  description = "The ID of the Railway project"
}

# Output the project name
output "project_name" {
  value       = railway_project.gymrats_image_server_project.name
  description = "The name of the Railway project"
}

# Output the service ID
output "service_id" {
  value       = railway_service.gymrats_image_server_service.id
  description = "The ID of the Railway service"
}

# Output the service name
output "service_name" {
  value       = railway_service.gymrats_image_server_service.name
  description = "The name of the Railway service"
}

# Output the service URL
output "service_url" {
  value       = railway_service.gymrats_image_server_service.service_url
  description = "The URL of the deployed Railway service"
}

# Output the environment ID (assuming you're using a specific environment)
output "environment_id" {
  value       = railway_service.gymrats_image_server_service.environment_id
  description = "The ID of the Railway environment"
}