provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami      = var.ami-id
  key_name = var.key
  instance_type = var.instance-type
  subnet_id = aws_subnet.demo_subnet.id
  availability_zone = var.subnet-az
  vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
  tags = {
    Name = "Terraform Test"
  }
  }


//Create VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc-cidr
}

//Create Subnet
resource "aws_subnet" "demo_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.subnet-cidr
  availability_zone = var.subnet-az
  map_public_ip_on_launch = true
  tags = {
    Name = "Demo_Subnet"
  }
}

//Create Internet Gateway

resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo-igw"
  }
}

//Create Route Table

resource "aws_route_table" "demo_RT" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

    tags = {
    Name = "demo-RT"
  }
}

//Associate Subnet with RT

resource "aws_route_table_association" "demo-assocaition" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo_RT.id
}

//Create SG

resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //cidr_ipv6   = "::/0"
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