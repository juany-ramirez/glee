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
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  count    = "${length(var.SUBNETS)}"
  cidr_block = "${element(keys(var.SUBNETS),count.index)}"
  availability_zone = "${element(var.SUBNETS[element(keys(var.SUBNETS),count.index)],0)}"
  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-subnet"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}
