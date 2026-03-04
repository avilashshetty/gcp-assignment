variable "name" {
  description = "Unique name of the bucket"
  type        = string
}

variable "location" {
  description = "Region or multi-region for bucket"
  type        = string
}

variable "storage_class" {
  description = "Bucket storage class"
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "Enforce uniform bucket-level IAM"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable object versioning"
  type        = bool
  default     = true
}

variable "retention_policy_days" {
  description = "Retention policy in days (0 = disabled)"
  type        = number
  default     = 0
}

variable "kms_key_name" {
  description = "CMEK key resource name (optional)"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Force destroy bucket even if not empty"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to bucket"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the bucket"
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                = optional(number)
      num_newer_versions = optional(number)
      with_state         = optional(string)
    })
  }))
  default = []
}