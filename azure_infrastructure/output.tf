
output "id" {
  value = azurerm_kubernetes_cluster.eqrdp.id
}

output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.eqrdp.kube_config_raw
}

output "client_key" {
  value = azurerm_kubernetes_cluster.eqrdp.kube_config.0.client_key
}

#output "client_certificate" {
#  value = azurerm_kubernetes_cluster.eqrdp.kube_config.0.client_certificate
#}

# output "cluster_ca_certificate" {
#   value = azurerm_kubernetes_cluster.eqrdp.kube_config.0.cluster_ca_certificate
# }

output "host" {
  value = azurerm_kubernetes_cluster.eqrdp.kube_config.0.host
}

output "admin_password" {
  sensitive = true
  value       = azurerm_container_registry.acr.admin_password
  description = "The object ID of the user"
}