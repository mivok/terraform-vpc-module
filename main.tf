data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "subnet" {
  count             = "${var.subnet_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  # Automatically split up the VPC address space equally between subnets
  cidr_block              = "${cidrsubnet(var.vpc_cidr, ceil(log(var.subnet_count, 2)), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}
