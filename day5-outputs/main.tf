resource "aws_instance" "dev" {
    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"
    key_name = "asuskey"
    tags = {
        Name = "dev"
    }

  
}