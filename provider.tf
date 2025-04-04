terraform {
  required_providers {
    spot = {
      source = "rackerlabs/spot"
    }
  }
}

provider "spot" {
  token = var.rackspace_spot_token
}
