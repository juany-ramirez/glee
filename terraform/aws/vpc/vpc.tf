terraform {
  backend "s3" {
    bucket = "acklen-terraform-state"
    region = "us-east-1"
  }
}
provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-vpc"
  }
}
