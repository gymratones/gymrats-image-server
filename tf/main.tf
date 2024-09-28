terraform {
  cloud {
    organization = "gymrats"
    hostname = "app.terraform.io"
    workspaces {
      name = "gymrats-image-server"
      project = "gymrats"
    }
  }
  required_providers {
    render = {
      source = "render-oss/render"
      version = "1.1.0"
    }
  }
}

provider "render" {
  api_key = var.provider_token
  owner_id = "usr-crrka6l6l47c73ckjvo0"
}

locals {
  project_name = "img-${var.branch_name}-gymrats"
}

resource "render_project" "gymrats_image_server_project" {
  name = "${local.project_name}-project"
  environments = {
    "${var.branch_name}" : {
      name : var.branch_name,
      protected_status : "protected"
    }
  }
}

resource "render_web_service" "gymrats_image_server_service" {
  name               = "${local.project_name}-service"
  plan               = "starter"
  region             = "frankfurt"
  start_command      = "gunicorn app:app"

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
}

resource "render_env_group" "gymrats_image_server_env_group" {
  name = "${local.project_name}-env-group"

  env_vars = {
    STORAGE_MODE = {
      value = var.storage_mode
    },
    B2_BUCKET_NAME = {
      value = var.b2_bucket_name
    },
    B2_KEY_ID = {
      value = var.b2_key_id
    },
    B2_APPLICATION_KEY = {
      value = var.b2_application_key
    }
  }
}