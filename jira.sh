#!/bin/bash

#install docker
apt install wget -y
wget -qO- https://get.docker.com/ | sh

#Start Docker Engine
service docker start

#sleep60s
sleep 10s

#install jira as a container
docker pull blacklabelops/jira

#create a container network
docker network create jiranet

sleep 10s

#Pull postgres image and run container and creating database
docker run --name postgres -d --network jiranet -v postgresvolume:/var/lib/postgresql -e 'POSTGRES_USER=jira' -e 'POSTGRES_PASSWORD=CloudEnabled' -e 'POSTGRES_DB=jiradb' -e 'POSTGRES_ENCODING=UNICODE' -e 'POSTGRES_COLLATE=C' -e 'POSTGRES_COLLATE_TYPE=C' blacklabelops/postgres

sleep 10s

#start jira
docker run -d --name jira --network jiranet -v jiravolume:/var/atlassian/jira -e "JIRA_DATABASE_URL=postgresql://jira@postgres/jiradb" -e "JIRA_DB_PASSWORD=CloudEnabled" -p 80:8080 blacklabelops/jira

sleep 10s






