

# Get the details of the GCP managed zone.
data "google_dns_managed_zone" "dns_zone" {
  name = var.clouddns_zone_name
}

#TODO: This needs to be converted to a foreach loop over the machines. 
# ** Manual hack warning ** - Assign the static IP for a specific machine to a subdomain.
# for example the address associated with the postgres vm has a new a record postgres.frogging.co.uk created dynamically. 




resource "google_dns_record_set" "postgres" {
  name         = "postgres.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name

  rrdatas = [google_compute_address.static_ip["matthewy-postgres-vm"].address]
}

resource "google_dns_record_set" "artifactory" {
  name         = "artifactory.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name

  rrdatas = [google_compute_address.static_ip["matthewy-artifactory-vm"].address]
}

# Create the blank VPC without any subnets
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create a single subnet and add it to the VPC. 
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.self_link
}

# Create the firewall rules and attach it to the VPC
resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = var.firewall_source_ranges
  
}

# For each VM created, attach a static IP (which will later be mapped to a DNS A record).
resource "google_compute_address" "static_ip" {
  for_each = toset(var.vm_set)
  name     = "matthewy-ip-${each.value}"
}

