variable "prefix" {
  description = "A prefix used for all resources in this example"
  default     = "prefectpoc"
}

variable "az_region" {
  description = "Azure Region"
  default     = "eastus"
}

variable "env" {
  description = "Environment"
  default     = "dev"
}