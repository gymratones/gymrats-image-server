terraform {
  required_providers {
    railway = {
      source = "terraform-community-providers/railway"
    }
  }
}

provider "railway" {}

module "railway_deployment" {
  source = "./modules/railway"
  
  bucket_name = var.BUCKET_NAME
}