resource "aws_security_group" "Bastion" {
  name        = var.sg-bastion
  description = "SG for Bastion-EC2"
  vpc_id      = var.vpc

  ingress {
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
    cidr_blocks = ["185.230.206.60/32", "84.54.76.31/32"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["82.209.240.102/32", "185.230.206.60/32", "84.54.76.31/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-bastion
  }
}
resource "aws_security_group" "Public" {
  name        = var.sg-public
  description = "SG for Public-EC2"
  vpc_id      = var.vpc

  ingress {
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
    cidr_blocks = ["172.33.1.0/24", "185.230.206.60/32", ]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["172.33.1.0/24", ]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-public
  }
}

resource "aws_security_group" "Private" {
  name        = var.sg-private
  description = "SG for Private-EC2"
  vpc_id      = var.vpc

  ingress {
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
    cidr_blocks = ["172.33.1.0/24", "172.33.3.0/24"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["172.33.1.0/24", "172.33.3.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-private
  }
}

resource "aws_security_group" "DB" {
  name        = var.sg-database
  description = "SG for Database-EC2"
  vpc_id      = var.vpc



  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["172.33.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-database
  }
}