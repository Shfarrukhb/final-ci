terraform {

  backend "s3" {
    encrypt = true
    bucket  = "tfstate-bucket-backend"
    dynamodb_table = "Dynamo-tfstate-lock"
    key    = "current-state.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



module "net" {
  source = "./modules/net"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_cidr_block   = var.public_cidr_block
  public_subnet_name  = var.public_subnet_name
  private_cidr_block  = var.private_cidr_block
  private_subnet_name = var.private_subnet_name
  db_cidr_block       = var.db_cidr_block
  db_subnet_name      = var.db_subnet_name
  igw                 = var.igw
  route_table         = var.route_table
  route_assoc         = var.route_assoc
  el_ip               = var.el_ip
  nat_gw              = var.nat_gw
  nat_rt              = var.nat_rt
}

module "sg" {
  source      = "./modules/sg"
  sg-bastion  = var.sg-bastion
  sg-public   = var.sg-public
  sg-private  = var.sg-private
  sg-database = var.sg-database
  vpc         = module.net.vpc_id

}

module "ec2" {
  source            = "./modules/ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  ec2_bas           = var.ec2_bas
  ec2_pub           = var.ec2_pub
  ec2_pri           = var.ec2_pri
  ec2_db            = var.ec2_db
  public_subnet_id  = module.net.public_subnet_id
  private_subnet_id = module.net.private_subnet_id
  db_subnet_id      = module.net.db_subnet_id
  sg-bastion-id     = module.sg.bastion_sg_id
  sg-public-id      = module.sg.public_sg_id
  sg-private-id     = module.sg.private_sg_id
  sg-database-id    = module.sg.database_sg_id

}

module "dynamo" {
  source = "./modules/dynamo"
  
}