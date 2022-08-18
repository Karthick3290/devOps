variable "cidr_block" {
  # default = "172.31.0.0/16"
  default = "192.168.0.0/16"
}

variable "name" {
  default = "kv-bootcamp"
}

# resource "random_string" "number" {
#   length  = 3
#   upper   = false
#   lower   = false
#   number  = true
#   special = false
# }

# variable "public_subnets_cidr" {
#   type        = list(any)
#   description = "CIDR block for Public Subnet"
#   # default     = ["172.31.32.0/24"]
#   default = ["192.168.32.0/24"]
# }

# variable "private_subnets_cidr" {
#   type        = list(any)
#   description = "CIDR block for Private Subnet"
#   # default     = ["172.31.31.0/24"]
#   default = ["192.168.31.0/24"]
# }

variable "region" {
  type        = list(any)
  default     = ["ap-south-1"]
  description = "Regions in which the hosts will be launched"
}

variable "ec2_ami" {
  type = map(any)
  default = {
    "ap-south-1" = "ami-0f2e255ec956ade7f"
    # "ap-south-1" = "ami-0e6837d3d816a2ac6"
    "af-south-1" = "ami-063a9ea2ff5685f7f"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
