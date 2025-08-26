variable "vpc_config" {
  description = "Please provide the VPC configuration details - vpc_name and cidr_block."
  type = object({
    vpc_name          = string
    cidr_block        = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The provided CIDR block is not valid. Please provide a valid CIDR block in the format 'x.x.x.x/x'. - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "Please provide the subnet configuration details - cidr_block and availability_zone."
  type = map(object({
    cidr_block = string
    availability_zone = string
    public = optional(bool, false)
  }))
  validation {
    condition     = alltrue([for subnet in values(var.subnet_config) : can(cidrnetmask(subnet.cidr_block))])
    error_message = "One or more provided CIDR blocks in subnet_config are not valid. Please provide valid CIDR blocks in the format 'x.x.x.x/x'."
  }
}