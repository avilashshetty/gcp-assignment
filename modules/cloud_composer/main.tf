resource "google_project_service" "composer_api" {
  project             = var.project_id
  service             = "composer.googleapis.com"
  disable_on_destroy  = false
}
 
resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "storage.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com"
  ])
 
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}
 
resource "google_service_account" "composer_sa" {
  project      = var.project_id
  account_id   = var.service_account_id    
  display_name = "Composer Environment Service Account"
}
 
resource "google_project_iam_member" "composer_roles" {
  for_each = toset([
    "roles/composer.worker",
    "roles/storage.objectAdmin",
    "roles/iam.serviceAccountTokenCreator",
  ])
 
  project = var.project_id
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
  role    = each.key
}
 
resource "google_composer_environment" "composer_env" {
  depends_on = [
    google_project_service.composer_api,
    google_project_service.required_apis,
    google_project_iam_member.composer_roles
  ]
 
  name    = var.composer_name
  region  = var.region
  project = var.project_id
 
  config {
 
    node_config {
      service_account = google_service_account.composer_sa.email
      network    = var.network
      subnetwork = var.subnetwork
    }
 
    software_config {
      image_version = var.image_version
      env_variables = var.env_variables
      pypi_packages = var.pypi_packages
    }
 
    environment_size = var.environment_size
 
    workloads_config {
      scheduler {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 20
        count      = 1
      }
 
      web_server {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 20
      }
 
      worker {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 20
        min_count  = 1
        max_count  = 3
      }
    }
  }
}
 
