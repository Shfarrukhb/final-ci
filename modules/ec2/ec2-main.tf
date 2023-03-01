resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = "${var.public_subnet_id}"
  vpc_security_group_ids      = ["${var.sg-bastion-id}"]
  associate_public_ip_address = true
  tags = {
    Name = var.ec2_bas
  }
}

resource "aws_instance" "Public-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = "${var.public_subnet_id}"
  vpc_security_group_ids      = ["${var.sg-public-id}"]
  associate_public_ip_address = true
  tags = {
    Name = var.ec2_pub
  }
}

resource "aws_instance" "Private-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = "${var.private_subnet_id}"
  vpc_security_group_ids      = ["${var.sg-private-id}"]
  associate_public_ip_address = false
  tags = {
    Name = var.ec2_pri
  }
}

resource "aws_instance" "Database-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = "${var.db_subnet_id}"
  vpc_security_group_ids      = ["${var.sg-database-id}"]
  associate_public_ip_address = false
  tags = {
    Name = var.ec2_db
  }
}