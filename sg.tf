resource "aws_security_group" "allow_ssm_traffic" {
  name        = "allow_ssm_traffic"
  description = "Allow SSM Agent communication"
  vpc_id      = "vpc-0cfaee6e11cf0915b" # Replace with your VPC ID

  # Ingress rules (adjust based on your needs)
  # If you are ONLY using SSM and not SSH, you don't need port 22 open.
  # If you are running a web server, you might need port 80 or 443 open.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to known IPs or remove if not needed
  }

  # Outbound rules - essential for SSM Agent to communicate with AWS SSM endpoints
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"] # Can be restricted to specific SSM endpoint IPs if VPC endpoints are used
  }

  tags = {
    Name = "Allow SSM Traffic"
  }
}
