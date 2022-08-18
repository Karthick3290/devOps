data "aws_availability_zones" "available" {}

resource "aws_vpc" "newvpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "${var.name}-vpc"
  }
}
#------------
#Public subnet
resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.newvpc.id
  count             = length(data.aws_availability_zones.available.names)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "192.168.${30 + count.index}.0/24"
  # cidr_block              = "192.${var.random_string.number}.${count.index}.0/24"
  map_public_ip_on_launch = true

  # vpc_id                  = aws_vpc.newvpc.id
  # cidr_block              = var.public_subnets_cidr[0]
  # map_public_ip_on_launch = true
  # availability_zone = "ap-south-1a"

  tags = {
    "Name" = "${var.name}-public_subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "aws_ig" {
  vpc_id = aws_vpc.newvpc.id
  tags = {
    "Name" = "${var.name}-igw"
  }
}

resource "aws_eip" "aws_nat_eip" {
  vpc = true
  tags = {
    "Name" = "${var.name}-eip"
  }
}

resource "aws_nat_gateway" "aws_nat" {
  allocation_id = aws_eip.aws_nat_eip.id
  subnet_id     = element(aws_subnet.public_subnets.*.id, 0)
  tags = {
    "Name" = "${var.name}-nat"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.newvpc.id

  tags = {
    "Name" = "${var.name}-public_route"
  }
}

resource "aws_route" "public_route_entry" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.aws_ig.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_route_association" {
  count = length("192.168.30.0/24")
  # count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

#------------
#Private subnet
resource "aws_subnet" "private_subnets" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.newvpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "192.168.${20 + count.index}.0/24"
  map_public_ip_on_launch = false


  # vpc_id     = aws_vpc.newvpc.id
  # cidr_block = var.private_subnets_cidr[0]
  # availability_zone       = "ap-south-1a"
  # map_public_ip_on_launch = false

  tags = {
    "Name" = "${var.name}-private_subnet-${count.index}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.newvpc.id

  tags = {
    "Name" = "${var.name}-private_route"
  }
}

resource "aws_route" "private_route_entry" {
  route_table_id         = aws_route_table.private_route_table.id
  gateway_id             = aws_nat_gateway.aws_nat.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_route_association" {
  count = length("192.168.20.0/24")
  # count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
