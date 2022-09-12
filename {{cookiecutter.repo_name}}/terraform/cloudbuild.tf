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

