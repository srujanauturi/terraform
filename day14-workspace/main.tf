resource "aws_instance" "name" {
    ami = "ami-08b5b3a93ed654d19"
    instance_type = "t2.micro"
    key_name = "asuskey"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev"
    }
   
  
}