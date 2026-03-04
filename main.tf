module "gcs_bucket" {
  source = "./modules/gcs_bucket"

  name     = "${var.project_id}-test-bucket"
  location = var.region
  labels   = var.labels

  versioning  = true
  force_destroy = false

}


module "bigquery_dataset" {
  source = "./modules/bigquery_dataset"

  dataset_id = var.bq_dataset_id
  location   = var.bq_location
  labels     = var.labels
  access = var.bq_access
}


module "cloud_function_v2" {
  source = "./modules/cloud_function_v2"

  name          = "hello-function-v2"
  region        = var.region
  runtime       = "python311"
  entry_point   = "hello_world"

  source_bucket = var.source_bucket
  source_object = var.source_object

  labels        = var.labels
}


module "gke_cluster" {
  source = "./modules/gke_cluster"
 
  cluster_name = "my-gke-cluster"
  location     = var.region
  network      = var.network
  subnetwork   = var.subnetwork
 
  node_machine_type = "e2-standard-2"
  node_count        = 1
 
  node_disk_type    = "pd-standard"
  node_disk_size_gb = 20
 
  labels = var.labels
  deletion_protection = false
}

module "cloud_composer" {
  source = "./modules/cloud_composer"
 
  project_id         = var.project_id
  region             = var.region
  composer_name      = var.composer_name
  service_account_id = var.service_account_id
 
  network    = var.network
  subnetwork = var.subnetwork
 
  image_version = var.image_version
 
  env_variables     = var.env_variables
  pypi_packages     = var.pypi_packages
  environment_size  = var.environment_size
}