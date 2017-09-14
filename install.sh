# install.sh - version 0.1
# ------------------------------------------------------------
# Update the instance
# ------------------------------------------------------------
sudo yum update -y

# Install Docker
# ------------------------------------------------------------
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Docker-compse
# ------------------------------------------------------------
curl -L https://github.com/docker/compose/releases/download/1.6.1/docker-compose-`uname -s`-`uname -m` > docker-compose 
sudo chown root docker-compose
sudo mv docker-compose /usr/local/bin
sudo chmod +x /usr/local/bin/docker-compose

# Clone the jenkins-ec2-docker project
# ------------------------------------------------------------
sudo git clone https://github.com/CraigsTraining/jenkins-ec2-docker

# Download and build the Jenkins image
# ------------------------------------------------------------
jenkins-ec2-docker/make build

# Start the Jenkins instance
# ------------------------------------------------------------
jenkins-ec2-docker/make start

# Get the admin password for the instance from
#	~/Jenkins/secrets/initialAdminPassword
# ------------------------------------------------------------
sudo cat Jenkins/secrets/initialAdminPassword
