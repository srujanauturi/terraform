variable "ami_id" {
    description = "inserting ami value"
    type = string
    default = "ami-053a45fff0a704a47"

}

variable "type" {
    type = string
    default = "t2.micro"


  
}

variable "key" {
    type = string
    default = "asuskey"
  
}