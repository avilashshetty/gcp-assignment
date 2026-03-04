variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Bucket region"
  type        = string
  default     = "us-central1"
}

variable "labels" {
  description = "Common labels"
  type        = map(string)
  default = {
    managed_by = "terraform"
    env        = "dev"
  }
}

variable "bq_dataset_id" {
  description = "BigQuery dataset ID to create."
  type        = string
  default     = "analytics_ds"
}

variable "bq_location" {
  description = "BigQuery dataset location (e.g., US, EU, us-central1)."
  type        = string
  default     = "US"
}

variable "bq_default_table_expiration_days" {
  description = "Default table expiration in days (0 = disabled)."
  type        = number
  default     = 0
}

variable "bq_access" {
  description = "List of access bindings for the dataset."
  type = list(object({
    role           = string
    user_by_email  = optional(string)
    group_by_email = optional(string)
    special_group  = optional(string)
    domain         = optional(string)
  }))
  default = []
}


variable "source_bucket" {
  type = string
}

variable "source_object" {
  type = string
}


variable "composer_name" {
  type = string
}
 
variable "service_account_id" {
  type = string
}
 
variable "network" {
  type = string
}
 
variable "subnetwork" {
  type = string
}
 
variable "image_version" {
  type    = string
  default = "composer-3-airflow-3.1.0"
}
 
variable "env_variables" {
  type    = map(string)
  default = {}
}
 
variable "pypi_packages" {
  type    = map(string)
  default = {}
}
 
variable "environment_size" {
  type    = string
  default = "ENVIRONMENT_SIZE_SMALL"
}