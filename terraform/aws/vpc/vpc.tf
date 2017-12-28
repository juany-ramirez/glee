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
    Name = "${var.APPNAME}-${terraform.workspace}-${element(var.SUBNETS[element(keys(var.SUBNETS),count.index)],0)}-${element(var.SUBNETS[element(keys(var.SUBNETS),count.index)],1)}"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
    Type = "${element(var.SUBNETS[element(keys(var.SUBNETS),count.index)],1)}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-gw"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_eip" "nat" {
  vpc      = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.main.0.id}"
  depends_on = ["aws_internet_gateway.gw","aws_eip.nat"]

  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-nat-gw"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}
