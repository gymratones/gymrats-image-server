terraform {
  backend "remote" {
    organization = "gymrats"
    hostname     = "app.terraform.io"
    workspaces {
      prefix = "img-"
    }
  }

  required_providers {
    render = {
      source  = "render-oss/render"
      version = "1.1.0"
    }
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.12"
    }
  }
}

provider "render" {
  api_key  = var.provider_token
  owner_id = var.provider_account_id
}

provider "b2" {
  application_key    = var.b2_application_key
  application_key_id = var.b2_key_id
}

resource "render_web_service" "gymrats_image_server_service" {
  name          = local.project_name
  plan          = "starter"
  region        = "frankfurt"
  start_command = "gunicorn app:app"

  runtime_source = {
    native_runtime = {
      auto_deploy   = true
      branch        = var.branch_name
      build_command = "pip install -r requirements.txt"
      build_filter = {
        paths         = ["server/**", "requirements.txt"]
        ignored_paths = ["tests/**"]
      }
      repo_url = "https://github.com/${var.github_repository}"
      runtime  = "python"
    }
  }

  env_vars = {
    STORAGE_MODE = {
      value = var.storage_mode
    },
    B2_BUCKET_NAME = {
      value = b2_bucket.gymrats_image_server_b2_bucket.bucket_name
    },
    B2_KEY_ID = {
      value = var.b2_key_id
    },
    B2_APPLICATION_KEY = {
      value = var.b2_application_key
    }
  }
}

resource "b2_application_key" "gymrats_image_server_b2_application_key" {
  key_name     = "${local.project_name}-application-key"
  capabilities = ["readFiles", "listFiles", "writeFiles"]
}

resource "b2_bucket" "gymrats_image_server_b2_bucket" {
  bucket_name = local.project_name
  bucket_type = "allPrivate"
}
