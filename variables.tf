variable "rackspace_spot_token" {
  description = "Rackspace Spot authentication token"
  type        = string
  sensitive   = true
}

variable "preemption_webhook" {
  description = "Slack webhook for preemption notifications"
  type        = string
  sensitive   = true
}