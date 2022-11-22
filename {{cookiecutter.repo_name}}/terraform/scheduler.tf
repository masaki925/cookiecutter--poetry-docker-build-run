resource "google_cloud_scheduler_job" "pr-env-cleaner" {
  name      = "pr-env-cleaner"
  schedule  = "0 3 * * *"
  time_zone = "Asia/Tokyo"

  pubsub_target {
    topic_name = google_pubsub_topic.pr_env_cleaner.id
    data = base64encode(jsonencode({
      "msg" = "PR env clean up by Cloud Build",
    }))
  }
}
