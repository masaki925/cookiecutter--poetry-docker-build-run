resource "google_cloudbuild_trigger" "{{ cookiecutter.repo_name }}-pr" {
  name        = "{{ cookiecutter.repo_name }}-pr"
  description = "{{ cookiecutter.repo_name }}: pr"

  github {
    owner = "{{ cookiecutter.repo_owner }}"
    name  = "{{ cookiecutter.repo_name }}"

    pull_request {
      branch = "^main$"
    }
  }

  filename = "cloudbuild-pr.yaml"

  substitutions = {
    _ENV = "pr-"
  }
}

resource "google_cloudbuild_trigger" "{{ cookiecutter.repo_name }}-dev" {
  name        = "{{ cookiecutter.repo_name }}-dev"
  description = "{{ cookiecutter.repo_name }}: dev"

  github {
    owner = "{{ cookiecutter.repo_owner }}"
    name  = "{{ cookiecutter.repo_name }}"

    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild-main.yaml"

  substitutions = {
    _ENV = "dev"
  }
}

###############################################################
# pr-env-cleaner
resource "google_cloudbuild_trigger" "pr-env-cleaner" {
  name        = "pr-env-cleaner"
  description = "PR env cleaner"

  pubsub_config {
    topic = google_pubsub_topic.pr_env_cleaner.id
  }

  build {
    step {
      name       = "gcr.io/cloud-builders/gcloud"
      entrypoint = "bash"
      args = [
        "-eEuo",
        "pipefail",
        "-c",
        <<-EOT
        gcloud run services list \
          --format="value(metadata.name)" \
          --filter="metadata.name~{{ cookiecutter.repo_name }}-pr-[0-9]+" > services.list
        cat services.list
        for name in $(cat services.list); do
          gcloud run services delete $name --region=asia-northeast1 --quiet
        done
        EOT
      ]
    }
  }
}

