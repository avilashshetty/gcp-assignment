output "dataset_id" {
  description = "Dataset ID."
  value       = google_bigquery_dataset.this.dataset_id
}

output "dataset_self_link" {
  description = "Self link of the dataset."
  value       = google_bigquery_dataset.this.self_link
}

output "dataset_location" {
  description = "Location of the dataset."
  value       = google_bigquery_dataset.this.location
}
