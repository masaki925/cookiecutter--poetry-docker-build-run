terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.35.0"
    }
  }
}

provider "google" {
  credentials = file("secret.json")

  project = "{{ cookiecutter.gcp_project_id }}"
  region  = "{{ cookiecutter.gcp_region }}"
  zone    = "{{ cookiecutter.gcp_zone }}"
}
