# Creating the CloudSpace
resource "spot_cloudspace" "kubernetes_cloudspace" {
  cloudspace_name    = "bianconi-dev"         ## Set The name of your Cloud Space here
  region             = "us-central-dfw-1"    ## Set region of your Cloud Space here, see the README.md for the options
  hacontrol_plane    = false              ## DON'T ENABLE THIS, YOU NEED TO PAY MORE!!!, ONLY ENABLE IF YOU WANT THE H.A FOR CONTROL PLANE!!!
  cni                = "cilium"          # Choose te CNI "calico" "cilium" or "byocni" (byocni bring you own CNI)
  kubernetes_version = "1.33.0"           # Kubernetes Version supported 1.33.0, 1.32.9, 1.31.1, 1.30.10, 1.29.6
  preemption_webhook = var.preemption_webhook
  wait_until_ready   = true
}

# Creating the Spot Nodepool
resource "spot_spotnodepool" "kubernetes_nodepool" {
  cloudspace_name = resource.spot_cloudspace.kubernetes_cloudspace.cloudspace_name
  server_class    = "gp.vs1.medium-dfw"     ## Server basic type, 2 cores and 4GB of RAM per node.
  bid_price       = 0.001                   ## Fixed bid price to pay only 0.001/hour per node instance!
  #desired_server_count = 0   ## Number of nodes that you want - Disabling to enable autoscaling - READ https://spot.rackspace.com/docs/en/autoscaling-a-spot-node-pool

## Enable Autoscaling with 1 node max 2 nodes
  autoscaling = {
    enabled   = true
    min_nodes = 1
    max_nodes = 2
  }

  labels = {
    "managed-by" = "terraform"
    "owner" = "luisbianconi"
  }
}

# Writing the kubeconfig file
resource "local_file" "kubeconfig" {
  content  = data.spot_kubeconfig.kubernetes_kubeconfig.raw
  filename = pathexpand("~/.kube/config")
}