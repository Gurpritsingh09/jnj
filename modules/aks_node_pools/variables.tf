variable "tags" {
  type        = map(string)
  description = "tags"
  default     = {}
}

variable "aks_cluster_id" {
  description = "(Required) ID of AKS cluster to attach the node pool to"
}

variable "subnet_id" {
  description = "(Required) ID of subnet where nodes should be placed"
}

variable k8s_node_pools {
  type = map(object({
    name                = string
    node_count          = number
    vm_size             = string
    os_disk_size_gb     = string
    os_type             = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    })
  )
}

variable "node-labels" {
  type    = map(string)
  default = {}
}

variable "node-taints" {
  type        = list
  description = "List of taints to assign to the node pool"
  default     = [""]
}
