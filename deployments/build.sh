#!/bin/bash
cd ..
git pull origin master \
&& cd deployments \
&& rm -rf logfv \
&& rm -rf logfv-server \
&& rm -rf logfv-server.war \
&& cd ../s2-logfv-site \
&& yarn install && npm run build \
&& mv build ../deployments/logfv \
&& cd ../server \
&& mvn package \
&& cp -rf target/logfv-server-release-1.0 ../deployments/logfv-server \
&& cp -rf target/logfv-server-release-1.0.war ../deployments/logfv-server.war \
&& cd ../deployments/dbInit && yarn install \
&& cd ../
docker stop logfv-app
docker rm logfv-app
docker rmi logfv:latest
docker build -t logfv:latest . \
&& rm -rf logfv \
&& rm -rf logfv-server \
&& rm -rf logfv-server.war
