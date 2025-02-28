terraform {
  backend "s3" {
    bucket = "naclibucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
