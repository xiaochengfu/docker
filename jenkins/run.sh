#!/bin/sh

docker run -v /usr/local/src/jenkins:/var/jenkins_home \
 -p 8080:8080 \
 --restart=always \
 --name docker-jenkins \
 -itd jenkins/jenkins:lts