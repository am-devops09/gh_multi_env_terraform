variable "instance_types_general" {
  type = list(string)
  description = "value"
}

variable "instance_types_spot" {
  type = list(string)
  description = "value"
}

variable "desired_size" {
  type = number
  default = "value"
}

variable "min_size" {
  type = number
  description = "value"
}

variable "max_size" {
  type = number
  description = "value"
}

variable "Environment" {
  type = string
  description = "value"
}

variable "disk_size" {
  type = number
  description = "value"
}


