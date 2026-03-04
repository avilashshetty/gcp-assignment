resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  initial_node_count       = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_type    = var.node_disk_type
    disk_size_gb = var.node_disk_size_gb
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    labels       = var.labels
  }

  network    = var.network
  subnetwork = var.subnetwork

  resource_labels = var.labels
  ip_allocation_policy {}
  deletion_protection = var.deletion_protection
}
