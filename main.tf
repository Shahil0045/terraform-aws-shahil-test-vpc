resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.vpc_name
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnet_config

  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_config.vpc_name}-subnet-${each.key}"
  }
}

locals {
  public_subnet = {
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnet = {
    for key, config in var.subnet_config : key => config if !config.public
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  count = length(keys(local.public_subnet)) > 0 ? 1 : 0
  tags = {
    Name = "${var.vpc_config.vpc_name}-igw"
  }
  
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  count = length(keys(local.public_subnet)) > 0 ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = {
    Name = "${var.vpc_config.vpc_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each = local.public_subnet
  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.public_rt[0].id
  
}