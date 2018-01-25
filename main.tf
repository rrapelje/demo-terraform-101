terraform {
  required_version = ">= 0.11.0"
}

variable "access_key" {
  description = "The AWS access key used to provision resources"
}

variable "secret_key" {
  description = "The AWS secret key used to provision resources"
}

variable "region" {
  description = "The AWS region in which to provision resources"
  default     = "us-west-2"
}

variable "identity" {
  description = "A unique name for your resources"
}

variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}

provider "aws" {
  version    = "~> 1.5"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "server" {
  source = "./server"

  num_webs = "${var.num_webs}"
  identity = "${var.identity}"
}

output "public_ip" {
  value = "${module.server.public_ip}"
}

output "public_dns" {
  value = "${module.server.public_dns}"
}
