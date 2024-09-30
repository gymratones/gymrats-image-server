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

# Output the B2 bucket_id
output "bucket_id" {
  value       = b2_bucket.gymrats_image_server_b2_bucket.bucket_id
  description = "The bucket ID of the B2 service"
}

# Output the B2 bucket_name
output "bucket_name" {
  value       = b2_bucket.gymrats_image_server_b2_bucket.bucket_name
  description = "The bucket name of the B2 service"
}
