# Provide resource configuration values
ami                    = "ami-0e001c9271cf7f3b9"
instance_type          = "t2.micro"
subnet_id              = "subnet-054b0151e579484e5"
key_name               = "mbandiofficial-nova"
user_data              = <<-EOF
                         #! /bin/bash 
                         sudo apt update -y 
                         sudo apt -y install apache2 
                         sudo systemctl start apache2 
                         sudo systemctl enable apache2 
                         sudo apt install wget -y 
                         sudo wget https://github.com/awanmbandi/google-cloud-projects/raw/jjtech-flix-app/jjtech-streaming-application-v1.zip 
                         sudo apt install unzip -y 
                         sudo unzip jjtech-streaming-application-v1.zip 
                         sudo rm -f /var/www/html/index.html 
                         sudo cp -rf jjtech-streaming-application-v1/* /var/www/html/ 
                         EOF 

## Security Group Variable Values
vpc_id                 = "vpc-08b0c56cb29df4c44"