variable "inputs" {

type = map(object({resource_group_name = string,resource_group_location=string,log_a_ws_name=string}))
description = "List of inputs"

}

variable "tags" {
  type = map(string)
  description = "tags"
}