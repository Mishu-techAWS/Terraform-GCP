resource "google_storage_bucket" "my-bucket" {
  name                     = "mishal-devops-gcp-terraform"
  project                  = "test-terraform-438504"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "inherited"
}

