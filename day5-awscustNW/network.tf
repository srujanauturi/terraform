#creating VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "prod_vpc"
    }

  
}
#creting subnet
resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "prod"
    }
  
}
resource "aws_subnet" "prod_private" {
  vpc_id = aws_subnet.prod.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
  
}

#creating intergateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "prod_ig"
    }
  
}
#creating route table   
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.prod.id

    route {
        gateway_id = aws_internet_gateway.prod.id
        cidr_block = "0.0.0.0/0"
    }    
  
}

#subnet association
resource "aws_route_table_association" "prod" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.prod.id

  
}


#creating security group  
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description = "TLS from ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


#server creation
resource "aws_instance" "prod" {
    ami = "ami-05b10e08d247fb927"
    instance_type = "t2.micro"
    key_name = "asuskey"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = {
      Name = "prod-ec2"
    }
  }  
  