module "dev" {
    source = "../day2-basic-code-for-module-source"
    ami_id = var.ami
    type = var.ami
    key = "asuskey"  
}