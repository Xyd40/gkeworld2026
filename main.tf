provider "google" {
  project = "gkeworld2026"
  region  = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_artifact_registry_repository" "my_repo" {
  location      = "us-central1"
  repository_id = "devops-lab"
  format        = "DOCKER"
}

resource "google_container_cluster" "primary" {
  name     = "gkeworld-cluster"
  location = "us-central1"
  network  = google_compute_network.vpc_network.name
  
  enable_autopilot = true
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-all"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
