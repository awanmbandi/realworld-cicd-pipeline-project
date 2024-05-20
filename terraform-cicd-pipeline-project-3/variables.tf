# Security Group Variables
variable "vpc_id" {
  type        = string
  description = "provide vpc id"
}

# EC2 Web Server Variables
variable "ami" {
  type        = string
  description = "provide an ubuntu or debian ami"
}

variable "instance_type" {
  type        = string
  description = "provide instance size"
}

variable "subnet_id" {
  type        = string
  description = "provide subnet id from your Default VPC"
}

variable "key_name" {
  type        = string
  description = "provide an existing keypair"
}

variable "user_data" {
  type        = string
  description = "provide userdata"
}
