#!/bin/bash
# Update system packages
yum update -y

# -------------------
# Install Java 21 (Amazon Corretto)
# -------------------
amazon-linux-extras enable corretto21
yum install -y java-21-amazon-corretto

# -------------------
# Add Jenkins repository and install Jenkins
# -------------------
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins

# Set JAVA_HOME for Jenkins
echo "JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto.x86_64" >> /etc/sysconfig/jenkins

# Enable and start Jenkins service
systemctl enable jenkins
systemctl start jenkins

# -------------------
# Install Git (for pipeline SCM checkout)
# -------------------
yum install -y git

# -------------------
# Install Terraform (latest stable version)
# -------------------
TERRAFORM_VERSION="1.9.5"
sudo yum install -y unzip
curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip
unzip terraform.zip
mv terraform /usr/local/bin/
rm -f terraform.zip

# -------------------
# Open firewall port 8080 if firewalld is running
# -------------------
if systemctl is-active --quiet firewalld; then
  firewall-cmd --permanent --zone=public --add-port=8080/tcp
  firewall-cmd --reload
fi

# -------------------
# Save initial Jenkins admin password
# -------------------
cat /var/lib/jenkins/secrets/initialAdminPassword > /var/log/jenkins-init.log
