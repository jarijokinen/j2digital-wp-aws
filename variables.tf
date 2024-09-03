variable "aws_assume_role_arn" {
  description = "AWS role to assume"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-west-1"
}

variable "lb_secret_header" {
  description = "X-Secret-Header value for the load balancer"
  default     = "secretvalue"
}
