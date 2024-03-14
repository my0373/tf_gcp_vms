variable "project_id" {
  description = "The ID of the project in which resources will be created."
  default     = "my-amazing-gcp-project"
}

variable "region" {
  description = "The region in which resources will be created."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which resources will be created."
  default     = "us-central1-a"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  default     = "10.0.0.0/16"
}

variable "vm_set" {
  description = "A list of the virtual machines to be created"
  type        = list(string)
  default     = ["artifactory-vm", "postgres-vm" ]


}
variable "machine_type" {
  description = "The machine type for the instance."
}

variable "image" {
  description = "The image from which the instance will be created."
  default     = "centos-cloud/centos-stream-9"
}

variable "instance_name_prefix" {
  description = "The prefix for the instance names."
  default     = "instance"
}

variable "vpc_name" {
  type        = string
  description = "The VPC name"
  default     = "vpc-test"

}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "subnet-test"
}

variable "firewall_name" {
  type        = string
  description = "The name of the firewall"
  default     = "firewall-test"
}

variable "subnet_private_access" {
  type        = bool
  description = "Allow private access to the subnet"
}

variable "subnet_flow_logs" {
  type        = bool
  description = "Allow the subnet flow logs"
}

variable "subnet_description" {
  type        = string
  description = "Subnet description."
}

variable "tags" {
  type        = list(any)
  description = "A list of tags to apply."
}

variable "clouddns_zone_name" {
  type        = string
  description = "Cloud DNS zone name"
  default     = "myfqdn-co-uk"

}

variable "local_ssh_public_key" {
  type        = string
  description = "The local path to your SSH public key"
  default     = "/home/myuser/.ssh/id_rsa.pub"
}

variable "storage_bucket_name" {
  type        = string
  description = "The name of the storage bucket to be created"
  default     = "test-storage-bucket"
}

variable "firewall_source_ranges" {
  type = list
  description = "List of source ranges allowed by the firewall"
  default = ["0.0.0.0/0",]
  
}

variable "firewall_source_ports" {
  type = list(string)
  description = "List of allowed ports into the GCP environment"
  default = ["22", "80", "443", "8080"]
}