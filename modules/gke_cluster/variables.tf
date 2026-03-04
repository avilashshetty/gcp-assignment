variable "cluster_name" { type = string }
variable "location"     { type = string }
variable "network"      { type = string }
variable "subnetwork"   { type = string }
 
variable "node_machine_type" {
  type    = string
  default = "e2-standard-2"
}
 
variable "node_count" {
  type    = number
  default = 1
}
 
variable "node_disk_type" {
  description = "Disk type for node pool (pd-standard | pd-balanced | pd-ssd)"
  type        = string
  default     = "pd-standard"
}
 
variable "node_disk_size_gb" {
  description = "Boot disk size per node (GB)"
  type        = number
  default     = 20
}
 
variable "labels" {
  type    = map(string)
  default = {}
}

variable "deletion_protection" {
  description = "If true, the GKE cluster cannot be deleted until this is set false."
  type        = bool
  default     = false
}
 