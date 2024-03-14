
# Create a storage bucket in the specifed region for VM's etc.
resource "google_storage_bucket" "bucket" {
  name     = var.storage_bucket_name
  location = var.region
  project  = var.project_id

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 365
    }
  }
}