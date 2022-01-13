#!/bin/bash

# 拷贝项目
rm -rf ./* \
&& cp -rf /home/logfv ./$URL_PATH \
&& cp -rf /home/logfv-server ./$URL_PATH-server \
&& cp -rf /home/logfv-server.war ./$URL_PATH-server.war \
&& cp -rf /home/dbInit ./dbInit \
&& cp -rf /home/dataway ./dataway
# 修改配置
sed -i 's@DB_HOST@'$DB_HOST'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_NAME@'$DB_NAME'@g;s@DB_USER@'$DB_USER'@g;s@DB_PASSWD@'$DB_PASSWD'@g' \
./$URL_PATH-server/WEB-INF/classes/db.properties
sed -i 's@DB_HOST@'$DB_HOST'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_NAME@'$DB_NAME'@g;s@DB_USER@'$DB_USER'@g;s@DB_PASSWD@'$DB_PASSWD'@g' \
./$URL_PATH-server/WEB-INF/classes/db.properties.production
sed -i 's@BASE_API@'$BASE_API'@g' ./$URL_PATH/biz/logfvSite/js/project.*
sed -i 's@DB_HOST@'$DB_HOST'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_NAME@'$DB_NAME'@g;s@DB_USER@'$DB_USER'@g;s@DB_PASSWD@'$DB_PASSWD'@g' ./dataway/config/application-prod.yml
sed -i 's@DB_HOST@'$DB_HOST'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_NAME@'$DB_NAME'@g;s@DB_USER@'$DB_USER'@g;s@DB_PASSWD@'$DB_PASSWD'@g' ./dbInit/config.json
sed -i 's@DB_HOST@'$DB_HOST'@g;s@DB_PORT@'$DB_PORT'@g;s@DB_NAME@'$DB_NAME'@g;s@DB_USER@'$DB_USER'@g;s@DB_PASSWD@'$DB_PASSWD'@g' ./dbInit/dbsql/initDB.sql
# 初始化表,启动服务
cd ./dbInit && node ./index.js
cd ../dataway && mkdir logs && ./application.sh start \
&& /usr/local/tomcat/bin/catalina.sh  run
