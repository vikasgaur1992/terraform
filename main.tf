# main.tf

resource "aws_instance" "example" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  key_name        = var.key_name
  count = 2
user_data = <<-EOF
             #!/bin/bash
              yum update -y
              yum install -y httpd mod_ssl
              systemctl start httpd
              systemctl enable httpd
              
              # Create a self-signed SSL certificate
              mkdir -p /etc/httpd/ssl
              openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
                -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
                -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt
              
              # Configure Apache to use the SSL certificate
              cat >> /etc/httpd/conf.d/ssl.conf << EOF
              <VirtualHost *:443>
                DocumentRoot "/var/www/html"
                ServerName www.example.com
                SSLEngine on
                SSLCertificateFile /etc/httpd/ssl/apache.crt
                SSLCertificateKeyFile /etc/httpd/ssl/apache.key
              </VirtualHost>
              EOF
              
              # Create a welcome page
#              echo "<html><h1>Welcome to the Test Website</h1></html>" > /var/www/html/index.html
#              EOF
  tags = {
    Name = "tftestinstance1"
    Apptype = "webserver"
    "BackupPlan"      = "tftest"
    "Patch Group"     = "tflinux"
    "Schedule"        = "Default"
    "Criticality"     = "testtier"
    "Requestor"       = "mailid"
    "Support"         = "mailid"
    "CostCenter"      = "testcostcenter"
    "DataClass"       = "testclass"
    "ApplicationID"   = "testappid"
    "applicationname" = "testappname"
    "assignmentgroup" = "testgroup"
    "BusinessMapping" = "testbusinessname"
  }

}
