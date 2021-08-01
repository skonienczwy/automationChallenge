# Configure the provider, region and your access/secret keys
provider "aws" {
  region     = var.region
  access_key = var.accessKey
  secret_key = var.secretKey
}

resource "aws_instance" "cgi-server" {
    ami = var.ami
    instance_type = var.instanceType
    key_name      = "main-key"
    security_groups = [aws_security_group.web.name]
    user_data = <<-EOF
                #!bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo apt install docker-compose -y
                sudo systemctl start docker.io
                sudo systemctl start docker-compose
                sudo git clone https://github.com/skonienczwy/automationChallenge.git
                sudo mkdir -p ~/docker-nginx/html
                cp automationChallenge/index.html ~/docker-nginx/html               
                sudo docker run --name docker-nginx -p 80:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx
                EOF
    

    tags = {
      "Name" = "DockerInstance"
    }

}

resource "aws_security_group" "web" {
    name = "web-security-group"
    description = "Allow access to the Web server"

    

    ingress {      
      description = "Allow SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    } 

    ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }




}
#output "instance_public_dns" {
 #   value = "aws_instance.web.public_dns"
  #  }