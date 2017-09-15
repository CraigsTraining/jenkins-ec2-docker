# Jenkins on Amazon Linux in a Docker Container

This repository demonstrates relatively simple steps to install the latest version of Jenkins (the leading open source automation server: https://jenkins.io/) on an Amazon Linux EC2 instance.

# Installation

## Update the Instance

The first step after logging into your new ECS instance is to update the components on your instance using the following Yum command:

``` sudo yum update -y ```

## Install Docker

Next install docker using the following commands:

```
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
```

Note: The last command sets permissions to allow the ec2-user to run the docker service.

## Logout and Back In

The change in permssions made above requires the ec2-user to log out and back in to continue with the next steps:

```logout```

## Install Docker-compose

The following commands download version 1.6.1 of docker-compose (the latest when this project was last updated), set ownership on the executable, move it to the ```/usr/local/bin``` directory, and modify its execution permissions.

```
curl -L https://github.com/docker/compose/releases/download/1.6.1/docker-compose-`uname -s`-`uname -m` > docker-compose 
sudo chown root docker-compose
sudo mv docker-compose /usr/local/bin
sudo chmod +x /usr/local/bin/docker-compose
```

## Install Git and Clone this Repository

The easiest way copy the project files to the EC2 instance is to use Git to clone the files. Git isn't installed on the instance by default so you will need to install it using:

```sudo yum install -y git```

Once Git is installed you can clone this project using the following command from the ec2-user home directory (```/home/ec2-user```):

```sudo git clone https://github.com/CraigsTraining/jenkins-ec2-docker```

This will clone the project files into:

```/home/ec2-user/jenkins-ec2-docker```

## Building the Jenkins Docker Image

Before you run Jenkins for the first time you need to build the Docker image it will user. The first step navigate to the project folder using:

```cd jenkins-ec2-docker/```

The run the following Docker commands:

```
docker pull jenkins/jenkins
docker-compose build
```

Once the build process completes you are ready to start your Jenkins instance.

# Running Jenkins

This section describes how to start and stop your Jenkins Docker container as well as how to get the intial administrative password when you first run your Jenkins instance.

## Start Jenkins

To start Jenkins use the following command from within the ```jenkins-ec2-docker``` directory:

```docker-compose up -d```

**Note**: If the is the first time you are running Jenkins you will need to get the instance's initial administrative password from secrets. Your ```JENKINS_HOME``` directory will be ```/home/ec2-user/Jenkins``` and you can use the following command to output the password:

```sudo cat ~/Jenkins/secrets/initialAdminPassword```

Your Jenkins instance will be available on port 8080 unless you modify the projects ```docker-compose.yml``` file.

## Stop Jenkins

If you need to stop your Jenkins Docker container you can use the following command from within the project directory:

```docker-compose down```

# Updating Jenkins 

If you wish to upgrade Jenkins to a later version you will first need to stop the instance (as described above) and then run the run the following commands:

```
docker pull jenkins/jenkins
docker-compose build
```

When the build process is completed you can start your instance again using:

```docker-compose up -d```



