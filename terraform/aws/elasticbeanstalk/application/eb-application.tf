terraform {
  backend "s3" {
    bucket = "acklen-terraform-state"
    key    = "${var.APPNAME}/eb-application"
    region = "us-east-1"
  }
}
provider "aws" {
  region     = "us-east-1"
}

resource "aws_elastic_beanstalk_application" "ebapplication" {
  name        = "${var.APPNAME}"
  description = "Backend for ${var.APPNAME}"
}