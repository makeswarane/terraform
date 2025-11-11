#!/bin/bash
# Example startup script
sudo apt update -y
sudo apt install -y nginx
echo "Hello from Terraform EC2" | sudo tee /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
