resource "aws_eip" "private" {
    domain = "vpc"
    tags = {
      Name = "elastic_ip"
    }
  
}
resource "aws_nat_gateway" "private" {
    allocation_id = aws_eip.private.id
    subnet_id = aws_subnet.prod.id
    tags = {
      Name = "my-nat"
    }
  
}

resource "aws_route_table" "private"{
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private.id
  }
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "natRT"
  }     
  
  
}

resource "aws_route_table_association" "prod_private" {
  subnet_id = aws_subnet.prod_private.id
  route_table_id = aws_route_table.private.id
  
}
resource "aws_instance" "private" {
  ami = "ami-05b10e08d247fb927"
  key_name = "asuskey"
  subnet_id = aws_subnet.prod.id
  instance_type = "t2.micro"
  
}

  
