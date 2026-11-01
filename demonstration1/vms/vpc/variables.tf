variable "env_name" {
    type = string
    description = "Environment name"
}

variable "zone" {
    type = string
    description = "Availability Zone"
}

variable "cidr" {
    type = list(string)  
    description = "List of CIDR blocks"
}