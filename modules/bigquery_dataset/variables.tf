variable "dataset_id" {
  description = "The dataset ID (must be unique within the project)."
  type        = string
}

variable "location" {
  description = "BigQuery dataset location (e.g., US, EU, us-central1)."
  type        = string
}

variable "labels" {
  description = "Labels to apply to the dataset."
  type        = map(string)
  default     = {}
}

variable "default_table_expiration_ms" {
  description = "Default expiration for tables in milliseconds (0 = disabled)."
  type        = number
  default     = 0
}

variable "default_partition_expiration_ms" {
  description = "Default expiration for partitions in milliseconds (0 = disabled)."
  type        = number
  default     = 0
}

variable "access" {
  description = <<EOT
Optional access rules. Provide a list of objects like:
[
  { role = "READER",  user_by_email = "user@example.com" },
  { role = "WRITER",  group_by_email = "data-writers@example.com" },
  { role = "OWNER",   special_group = "projectOwners" },
  { role = "READER",  domain = "example.com" }
]
Only one of user_by_email / group_by_email / special_group / domain should be set per item.
EOT
  type = list(object({
    role           = string
    user_by_email  = optional(string)
    group_by_email = optional(string)
    special_group  = optional(string)
    domain         = optional(string)
  }))
  default = []
}