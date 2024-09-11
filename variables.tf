variable "vpc_config" {
  description = "to get the CIDR and Name of VPC from user"  
  type = object({
    name = string
    cidr_block =string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR format - ${var.vpc_config.cidr_block}"
  } 
}

variable "subnet_config" {
    description = "to get the CIDR and AZ for subnets"
    type = map(object({
      cidr_block = string
      azs = string
      public = optional(bool, false)
    }))
    validation {
    # sub1={cidr=} sub2={cidr=..}, [true, true, false]
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
    }
  
}