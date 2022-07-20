#!/bin/bash
cd .. \
&& cd deployments \
&& rm -rf logdog \
&& rm -rf logdog-server \
&& rm -rf logdog-server.war \
&& cd ../s2-logdog-site \
&& yarn install && npm run build \
&& mv build ../deployments/logdog \
&& cd ../server \
&& mvn package \
&& cp -rf target/logdog-server-release-1.0 ../deployments/logdog-server \
&& cp -rf target/logdog-server-release-1.0.war ../deployments/logdog-server.war \
&& cd ../deployments/dbInit && yarn install \
&& cd ../
docker stop logdog-app
docker rm logdog-app
docker rmi logdog:latest
docker build -t logdog:latest . \
&& rm -rf logdog \
&& rm -rf logdog-server \
&& rm -rf logdog-server.war
