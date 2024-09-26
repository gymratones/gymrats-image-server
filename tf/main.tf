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

module "railway_deployment" {
  source = "./modules/railway"
  
  bucket_name = var.BUCKET_NAME
}