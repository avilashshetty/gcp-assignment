output "bucket_name" {
  description = "Name of the created bucket"
  value       = module.gcs_bucket.bucket_name
}

output "bucket_url" {
  description = "URL of the created bucket"
  value       = module.gcs_bucket.bucket_url
}

output "bucket_self_link" {
  description = "Self link of the bucket"
  value       = module.gcs_bucket.self_link
}


output "bigquery_dataset_id" {
  description = "Created dataset ID."
  value       = module.bigquery_dataset.dataset_id
}

output "bigquery_dataset_location" {
  description = "Created dataset location."
  value       = module.bigquery_dataset.dataset_location
}

output "bigquery_dataset_self_link" {
  description = "Self link for the dataset."
  value       = module.bigquery_dataset.dataset_self_link
}


output "function_v2_name" {
  value = module.cloud_function_v2.function_name
}

output "function_v2_url" {
  value = module.cloud_function_v2.uri
}



output "gke_cluster_name" {
  value = module.gke_cluster.cluster_name
}

output "gke_cluster_endpoint" {
  value = module.gke_cluster.endpoint
}

output "gke_cluster_ca_cert" {
  value = module.gke_cluster.ca_certificate
}
