variable "vpc_cidr_block" {
  description = "IP range for the VPC"
  type = string
  default = "10.16.0.0/16"
}

variable "private_subnet_ranges" {
 description = "List of private subnet IP ranges" 
 type = list(string)
 default = [ /*
   "10.16.0.0/20", 
   "10.16.16.0/20",
   "10.16.32.0/20",
   "10.16.48.0/20", */
   "10.16.64.0/20",
   "10.16.80.0/20"   
   ]
}

variable "public_subnet_ranges" {
 description = "List of public subnet IP ranges" 
 type = list(string)
 default = [ 
  "10.16.96.0/20",
  "10.16.112.0/20"
   ]
}

variable "tags" {
  type = map(string)
  default = {
    "project" = "epam"
  }
}
variable "instance_id" {
  
}
