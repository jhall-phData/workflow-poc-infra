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
  descrdescription = "service principle client id"
}

variable "workflow-poc-sp-tenant-id" {
  descrdescription = "service principle tenant id"
}

variable "workflow-poc-sp-secret" {
  descrdescription = "service principle secret"
}