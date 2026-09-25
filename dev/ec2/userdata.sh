#!/bin/bash
# Update system packages
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Create a sample HTML page with the server hostname
echo "<html>
  <head><title>App Server</title></head>
  <body>
    <h1>Welcome to App Server: $(hostname)</h1>
  </body>
</html>" > /var/www/html/index.html
