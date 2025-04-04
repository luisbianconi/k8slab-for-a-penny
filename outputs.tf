output "kubeconfig" {
  value = data.spot_kubeconfig.kubernetes_kubeconfig.raw
  sensitive = true
}