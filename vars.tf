variable "project_name" {
  default = "portworx-gcp-test"
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-d"
}

variable "prefix" {
  default = "px"
}

variable "node-count" {
  description = "# nodes"
  default     = 3
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "your_account.json"
}

variable "volsize" {
  description = "Volume size "
  default     = 20
}

variable "private_key_path" {
  description = "private key path"
  default     = "id_ed25519"
}

variable "public_key_path" {
  description = "ssh_key"
  default     = "id_ed25519.pub"
}

variable "k8s_version" {
  default = "1.7.3-01"
}

variable "k8s_init_version" {
  default = "1.7.3"
}

variable "k8s_token" {
  default = "123456.0123456789abcdef"
}
