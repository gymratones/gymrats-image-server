# Output the project ID
output "project_id" {
  value       = render_project.gymrats_image_server_project.id
  description = "The ID of the Render project"
}

# Output the project name
output "project_name" {
  value       = render_project.gymrats_image_server_project.name
  description = "The name of the Render project"
}

# Output the service ID
output "service_id" {
  value       = render_web_service.gymrats_image_server_service.id
  description = "The ID of the Render service"
}

# Output the service name
output "service_name" {
  value       = render_web_service.gymrats_image_server_service.name
  description = "The name of the Render service"
}

# Output the service URL
output "service_url" {
  value       = render_web_service.gymrats_image_server_service.url
  description = "The URL of the Render service"
}
