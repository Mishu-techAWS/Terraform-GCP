# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Backend configuration to store the Terraform state in a GCS bucket
terraform {
  backend "gcs" {
    bucket  = var.gcs_bucket_name  # The bucket where the tfstate will be stored
    prefix  = "terraform/state"    # Folder/prefix in the bucket
  }
}

# Create a VPC
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false  # Disable auto-creation of subnetworks
}

# Create a subnet in the VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Create a VM instance in the VPC and subnet
resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-instance"
  machine_type = "e2-micro"
  zone         = var.zone

  # Define boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Use a Debian image
    }
  }

  # Use the default network interface with the VPC and subnet
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id    
  }  
}

# Output instance IP address
output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}


