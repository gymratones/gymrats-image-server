variable "provider_token" {
  type        = string
  description = "Provider Token"
}

variable "github_repository" {
  type        = string
  description = "Full Github repository name"
}

variable "branch_name" {
  type        = string
  description = "Name of the current Git branch"
}

variable "storage_mode" {
  type        = string
  description = "Storage mode for Image Server"
}

variable "b2_bucket_name" {
  type        = string
  description = "Backblaze B2 Bucket name"
}

variable "b2_key_id" {
  type        = string
  description = "Backblaze B2 KeyID"
}

variable "b2_application_key" {
  type        = string
  description = "Backblaze B2 ApplicationKey"
}