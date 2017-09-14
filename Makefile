# 
default: 
	# make build 	- Pulls the latest docker image and runs the docker-compose build command
	# make start 	- Starts the Jenkins docker container
	# make stop  	- Stops the Jenkins docker container
	
build:
	docker pull jenkins/jenkins
	docker-compose build	

start:
	docker-compose up -d

stop:
	docker-compose down