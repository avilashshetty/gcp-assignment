project_id = "gcp-assign"

region = "us-central1"

labels = {
  managed_by = "terraform"
  env        = "dev"
}


bq_dataset_id = "analytics_ds"
bq_location   = "US"

bq_default_table_expiration_days = 0


source_bucket  = "cf2-source-gcp-assign"
source_object  = "function.zip"


network    = "default"
subnetwork = "default"

composer_name     = "composer-demo"
service_account_id = "composer-demo-sa"
 
 
image_version = "composer-3-airflow-3.1.0"
 
env_variables = {
  ENV = "dev"
}
 
pypi_packages = {
  pandas  = ""
  requests = ""
}