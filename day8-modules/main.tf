module "dev" {
    source = "../day2-basic-code-for-module-source"
    ami_id = "ami-053a45fff0a704a47"
    type = "t2.micro"
    key = "asuskey"  
}