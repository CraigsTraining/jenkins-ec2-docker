FROM jenkins/jenkins

USER root

# Update & Upgrade OS
RUN apt-get update \
 && apt-get -y upgrade

# Add Maven
RUN apt-get -y install maven --no-install-recommends

# Add Docker
RUN curl -sSL https://get.docker.com/ | sh
