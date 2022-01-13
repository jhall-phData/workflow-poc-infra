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

variable "workflow-poc-sp-client-id" {
  description = "service principle client id"
}

variable "workflow-poc-sp-tenant-id" {
  description = "service principle tenant id"
}

variable "workflow-poc-sp-secret" {
  description = "service principle secret"
}
