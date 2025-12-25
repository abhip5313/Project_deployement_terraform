provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
  
}

resource "aws_instance" "my-backend-ec2" {
    ami = var.ami_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
    key_name = aws_key_pair.ec2-key.key_name
    tags = {
      name = "my-backend-server"
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("./yes")
      host = self.public_ip
    }

provisioner "remote-exec" {
    inline = [ 
        "sudo yum update -y",
        "mkdir student-api",
        "cd student-api",
        "sudo yum install -y nodejs",
        "curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -",
        "node -v",
        "npm -v",
        "sudo yum install git -y",
        "git init",
        "git remote add origin ${var.github_repo_url}",
        "git pull origin master",
        "npm init -y",
        "npm install mysql",
        "npm install",
        "sudo npm install -g pm2",
        "npm install express cors body-parser mysql2",
        "pm2 restart student-api",
        "pm2 start server.js --name student-api",
        "pm2 list",
        "cd /home/ec2-user/student-api",
        "node server.js"

     ]
  
}
}

resource "aws_security_group" "ec2-sg" {
    name = "my-ec2-sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "for ssh connection"

    }  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "for http connection"

    }  

    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "for port connection"

    }  

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow all traffic"
    }

}

resource "aws_key_pair" "ec2-key" {
    key_name = "yes"
    public_key = file("./yes.pub")
  
}