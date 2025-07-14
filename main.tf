# Creating the CloudSpace
resource "spot_cloudspace" "kubernetes_cloudspace" {
  cloudspace_name    = "bianconi-dev"         ## Set The name of your Cloud Space here
  region             = "us-east-iad-1"    ## Set region of your Cloud Space here, see the README.md for the options
  hacontrol_plane    = false              ## DON'T ENABLE THIS, YOU NEED TO PAY MORE!!!, ONLY ENABLE IF YOU WANT THE H.A FOR CONTROL PLANE!!!
  cni                = "cilium"          # Choose te CNI "calico" "cilium" or "byocni" (byocni bring you own CNI)
  kubernetes_version = "1.31.1"           # Kubernetes Version supported 1.29.6 | 1.30.10 | 1.31.1
  preemption_webhook = var.preemption_webhook
  wait_until_ready   = true
}

# Creating the Spot Nodepool
resource "spot_spotnodepool" "kubernetes_nodepool" {
  cloudspace_name = resource.spot_cloudspace.kubernetes_cloudspace.cloudspace_name
  server_class    = "gp.vs1.medium-iad"     ## Server basic type, 2 cores and 4GB of RAM per node.
  bid_price       = 0.001                   ## Fixed bid price to pay only 0.001/hour per node instance!
  #desired_server_count = 2   ## Number of nodes that you want - Disabling to enable autoscaling - READ https://spot.rackspace.com/docs/en/autoscaling-a-spot-node-pool

## Enable Autoscaling with 1 node max 2 nodes
  autoscaling = {
    enabled   = true
    min_nodes = 1
    max_nodes = 2
  }
}

# Getting the kubeconfig file
# To see RUN: "tofu/terraform output kubeconfig" command
# If Fails, you can download on your rackspace the kubeconfig file!
data "spot_kubeconfig" "kubernetes_kubeconfig" {
  cloudspace_name = resource.spot_cloudspace.kubernetes_cloudspace.cloudspace_name
}