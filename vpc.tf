data "aws_availability_zones" "example" {
  state = "available"
}

resource "aws_subnet" "example_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.ipv4_cidr, 1, 0)
  availability_zone       = data.aws_availability_zones.example.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "example_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.ipv4_cidr, 1, 1)
  availability_zone       = data.aws_availability_zones.example.names[1]
  map_public_ip_on_launch = true
}