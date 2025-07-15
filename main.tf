# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Configure the AWS Resources
resource "aws_instance" "amazon_linux_2_instance" {
  ami           = "ami-0150ccaf51ab55a51" # Amazon Linux 2 AMI for us-east-1)
  instance_type = "t2.micro"  #  Free tier eligible
  key_name      = aws_key_pair.local2.key_name # Referencing the key pair resource
  vpc_security_group_ids = [aws_security_group.allow_ssm_traffic.id] # Referencing the security group resource
  subnet_id = "subnet-0cb19968efe6f1e57" # Replace with your subnet ID
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name # Attach the instance profile
  
  tags = {
    Name = "ChinnaWebServerwithSSM"
  }

# Configure the AWS user data

# how to add the below userdata in to the terrform main.tf
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Hello from Chinna the Terraform on Amazon Linux 2!</h1>" | sudo tee /var/www/html/index.html
    
  EOF
}
