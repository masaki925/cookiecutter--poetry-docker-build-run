{{cookiecutter.repo_name}}

## Dependencies

- [Poetry](https://python-poetry.org/)
- [Docker](https://www.docker.com/)
- [Terraform](https://www.terraform.io/)
- [Google Cloud](https://cloud.google.com/)

## Features

- [FastAPI](https://fastapi.tiangolo.com/)
- [Cloud Run](https://cloud.google.com/run)
- [Cloud Build](https://cloud.google.com/build)
- [pytest](https://docs.pytest.org/)

## Setup

### local

```
docker compose up
```

access to http://localhost:18001/

### GitHub & GCP

- Setup GitHub repo
  - follow GitHub instruction: https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository

- Setup terraform
  - create Service Account secret at https://console.cloud.google.com/iam-admin/serviceaccounts?project=$(PROJECT_ID)
    - set Editor role for development
  - put secret file as terraform/secret.json
  - `cd terraform`
  - `terraform init`
  - `terraform plan && terraform apply`

- Connect GitHub repository and Cloud Build 
  - access to https://console.cloud.google.com/cloud-build/triggers/connect?project=$(PROJECT_ID)
  - follow instruction

- `terraform apply`

- push to repo
  - it triggers Cloud Build which deploy the app to Cloud Run
  - check the log and note the Cloud Run endpoint URL

- access to Cloud Run with auth token
  - set `CLOUD_RUN_FQDN` in Makefile with Cloud Run endpoint URL
  - `make curl_to_cloud_run` 
    - it requires `gcloud auth print-identity-token` run properly
  - you must get response `{"message":"Hello World"}`

## Commands

```
$ make
build                          build
curl_to_cloud_run              curl to Cloud Run (hint: ENV=pr-xxx)
format                         pysen run format
help                           help lists
init                           poetry install
lint                           pysen run lint
server                         start server
test                           test
```

