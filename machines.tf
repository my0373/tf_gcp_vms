

# Create a VM in GCP for each entry in the variable "vm_set"
# Allow SSH logins by default, and assign a public facing static IP to each machine. 
resource "google_compute_instance" "vm_instance" {

  for_each     = toset(var.vm_set)
  name         = "${var.instance_name_prefix}-${each.value}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
    "enable-oslogin" = "TRUE"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link

    access_config {
      nat_ip = google_compute_address.static_ip[each.value].address
    }
  }

}