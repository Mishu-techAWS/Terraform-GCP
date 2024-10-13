variable "project_id" {
  description = "The project ID where the resources will be created"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the VM will be created"
  type        = string
  default     = "us-central1-a"
}

variable "gcs_bucket_name" {
  description = "The name of the GCS bucket to store Terraform state"
  type        = string
}
