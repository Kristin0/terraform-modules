resource "aws_vpc" "main"{
  cidr_block = var.vpc_cidr_block
  tags = var.tags
  enable_dns_hostnames = true
}

data "aws_availability_zones" "available" {
  state = "available"
}



resource "aws_subnet" "private" {
  count = length(var.private_subnet_ranges)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_ranges[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_ranges)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_ranges[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet-${count.index}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    "Name" = "public-route-table-epam"
  }
}

resource "aws_route_table" "private" {
  
  vpc_id = aws_vpc.main.id
  route   {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  
  tags = {
    "Name" = "private-route-table-epam"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "epam-igw"
  }

}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ranges)   
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_ranges) 
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private[count.index].id
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public[0].id
  tags = {
    "Name" = "epam-nat-gw"
  }
}

resource "aws_eip" "eip" {
  
}