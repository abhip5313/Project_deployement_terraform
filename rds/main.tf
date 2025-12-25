provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key

}

resource "aws_db_instance" "my-tf-db" {
  engine                 = "mysql"
  db_name                = var.db_name
  allocated_storage      = 20
  engine_version         = "8.0"
  instance_class         = var.instance_class
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  username               = var.username
  password               = var.password
  tags = {
    name = "my-backend-tf-rds"
  }
  publicly_accessible = true
  skip_final_snapshot = false
}

resource "aws_security_group" "rds-sg" {
  name = "rds-sg"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
    description = "for db access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all traffic allow"
  }

}