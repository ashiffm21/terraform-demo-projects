variable "region" {
  default = "ap-south-1"
}

variable "ami-id" {
  default = "ami-0522ab6e1ddcc7055"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "key" {
  default = "demo-key"
}

variable "vpc-cidr" {
  default = "10.10.0.0/16"
}

variable "subnet-cidr" {
  default = "10.10.1.0/24"
}

variable "subnet-az" {
  default = "ap-south-1a"
}