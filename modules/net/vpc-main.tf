resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_cidr_block
  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_cidr_block
  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.db_cidr_block
  tags = {
    Name = var.db_subnet_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table
  }
}

resource "aws_route_table_association" "public_sub_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table.id

}

resource "aws_eip" "elastic_ip" {
  vpc = true
  tags = {
    Name = var.el_ip
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = var.nat_gw
  }
}

resource "aws_route_table" "nat_rt-2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = var.nat_rt
  }
}

resource "aws_route_table_association" "nat_rt_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.nat_rt-2.id
}  