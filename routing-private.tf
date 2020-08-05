resource "aws_eip" "nat_gw" {
  tags = merge({
    Name = "${var.name_prefix}natgw-ip"
    },
    var.common_tags
  )
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public[keys(aws_subnet.public)[0]].id

  depends_on = [aws_internet_gateway.gw]
  tags = merge({
    Name = "${var.name_prefix}natgw"
    },
    var.common_tags
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "${var.name_prefix}private-rtb"
    },
    var.common_tags
  )
}

resource "aws_route" "default_nat_gw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}