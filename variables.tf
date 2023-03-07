variable "region" {
  type        = string
  description = "The was region"
  default     = "us-east-1"
}

variable "my_access_key" {
  type = string
  description = "The aws access key"
}

variable "my_secret_key" {
  type = string
  description = "The aws secret key"
}