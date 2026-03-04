Introduction
This project shows how I built and automated Google Cloud Platform (GCP) infrastructure using Terraform and a Python script.
I created separate Terraform modules for each main GCP service so the setup is clean, reusable, and easy to understand.
The services included in this project are:

Google Cloud Storage (GCS) Bucket
BigQuery Dataset
Cloud Function (infrastructure only)
GKE Cluster
Cloud Composer Environment
A Python script to create buckets automatically

The goal was to learn how these cloud resources work, how Terraform helps in organizing infrastructure, and how Python can automate simple tasks.
I tried to keep the project modular, neat, and close to real DevOps practices.

Project Structure
gcp-infra-terraform/
│
├── modules/
│   ├── gcs_bucket/
│   ├── bigquery_dataset/
│   ├── cloud_function_v2/
│   ├── gke_cluster/
│   └── cloud_composer_v2/
│
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── providers.tf
│       ├── versions.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── backend.tf
│
└── scripts/
     └── app.py

Each module is fully reusable and takes input variables.
The envs/dev folder is the environment where all modules are combined to deploy the complete infrastructure.

1. GCS Bucket
What I Learned
A GCS bucket is used to store files in Google Cloud. This includes files like logs, backups, function code, and Terraform state.
I learned that bucket names must be globally unique and that versioning helps recover old files.
Why It Is Needed
Buckets are used by many cloud services:

Cloud Functions store their code here
BigQuery uses it when loading data
CI/CD pipelines store build artifacts
Applications store uploaded files

So creating a bucket is usually one of the first steps in cloud projects.
How I Ran It
cd envs/dev
terraform init
terraform apply -target="module.gcs_bucket"


2. BigQuery Dataset
What I Learned
A BigQuery dataset is like a folder where BigQuery tables and views live. BigQuery is a serverless data warehouse used for analytics and big SQL workloads.
Why It Is Needed
Datasets help:

Organize analytics data
Manage permissions
Run ETL/ELT pipelines
Work with tools like Dataflow and Cloud Functions

This is the base for any analytics platform.
How I Ran It
terraform apply -target="module.bigquery_dataset"


3. Cloud Function (Infrastructure Only)
What I Learned
Cloud Functions Gen2 is a serverless compute tool. Gen2 uses Cloud Run, which gives more speed and scaling.
In this project, I created only the infrastructure—no actual function code.
The module sets up:

runtime
region
service account
the Cloud Function resource
a bucket for storing function code

Why It Is Needed
Cloud Functions are used for small tasks like:

sending notifications
processing images
reacting to bucket events

How I Ran It
terraform apply -target="module.cloud_function"


4. GKE Cluster
What I Learned
GKE (Google Kubernetes Engine) is a managed Kubernetes service.
This was the most complex module. I learned:

GKE needs a VPC, subnet, and IP ranges
Node pools define machine types and scaling
Zonal clusters are simpler; regional clusters give more availability
Workload Identity links Kubernetes to GCP IAM

Why It Is Needed
Kubernetes is used to run container-based applications at scale.
Learning to deploy GKE using Terraform teaches real DevOps practices.
How I Ran It
terraform apply -target="module.gke_cluster"


5. Cloud Composer Environment
What I Learned
Cloud Composer is Google’s managed Airflow service. It is used for workflows and data pipelines.
I learned that:

Composer v2 runs on GKE Autopilot
It needs a dedicated service account
It takes time (20–40 minutes) to create
Composer creates its own bucket for DAGs

Why It Is Needed
Data engineering projects need orchestration to manage complex pipelines. Composer makes this easy without installing Airflow manually.
How I Ran It
terraform apply -target="module.composer"


6. Python Automation Script
What I Learned
The app.py script creates a GCS bucket using Python.
It runs PowerShell commands like:

gcloud to select the project
enabling APIs
gsutil to create a bucket

This shows how Python can automate cloud tasks.
Why It Is Needed
This script demonstrates:

Cloud automation
Running shell commands from Python
Basic DevOps scripting

How I Ran It
python scripts/app.py --project <PROJECT_ID> --region asia-south1 --bucket my-bucket-123


How to Deploy Everything
Step 1: Go to environment folder
cd envs/dev

Step 2: Initialize Terraform
terraform init

Step 3: Preview
terraform plan

Step 4: Apply
terraform apply

Step 5: Destroy
terraform destroy


What I Learned Overall

How different GCP services connect and depend on each other
How to build reusable Terraform modules
How to organize cloud infrastructure
Networking basics (important for GKE and Composer)
Using IAM and service accounts
Automating cloud tasks with Python
Following Infrastructure‑as‑Code best practices
Debugging real cloud problems
Maintaining clean code with .gitignore


Conclusion
This project helped me understand Terraform module design and how major GCP services work together. With separate modules and automation using Python, the setup is clean, reusable, and easy to extend in the future.