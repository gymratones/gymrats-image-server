terraform {
  required_providers {
    railway = {
      source = "terraform-community-providers/railway"
    }
  }
}

provider "railway" {
  token = "aaaa"
}

module "railway_deployment" {
  source = "./modules/railway"
  
  bucket_name = var.BUCKET_NAME
}