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

resource "aws_route_table" "rtpulbic" {
  depends_on = ["aws_internet_gateway.gw"]
  vpc_id = "${aws_vpc.main.id}"  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }  
  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-rt-public"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table" "rtprivate" {
  depends_on = ["aws_internet_gateway.gw"]
  vpc_id = "${aws_vpc.main.id}"  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = "${aws_nat_gateway.natgw.id}"
  }
  tags {
    Name = "${var.APPNAME}-${terraform.workspace}-rt-private"
    Project = "${var.APPNAME}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "rtspublic" {
  count = "${length(aws_subnet.main.*.id)/2}"
  subnet_id      = "${element(aws_subnet.main.*.id,count.index * 2)}"
  route_table_id = "${aws_route_table.rtpulbic.id}"
}

resource "aws_route_table_association" "rtsprivate" {
  count = "${length(aws_subnet.main.*.id)/2}"
  subnet_id      = "${element(aws_subnet.main.*.id,count.index + 1 + count.index)}"
  route_table_id = "${aws_route_table.rtprivate.id}"
}
