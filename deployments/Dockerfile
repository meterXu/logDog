FROM tomcat:9.0-jre8
MAINTAINER isaac

ENV DB_HOST=${DB_HOST}
ENV DB_PORT=3306
ENV DB_NAME=${DB_NAME}
ENV DB_USER=root
ENV DB_PASSWD=${DB_PASSWD}
ENV URL_PATH=logdog
ENV BASE_API=${BASE_API}
ENV TZ=Asia/Shanghai
ENV PATH=/usr/local/lib/nodejs/bin:${PATH}
USER root
WORKDIR /home
EXPOSE 8080 9191
COPY docker-entrypoint.sh ./
COPY logdog ./logdog
COPY logdog-server ./logdog-server
COPY logdog-server.war ./logdog-server.war
COPY nodejs ./nodejs
COPY dbInit ./dbInit
COPY dataway ./dataway
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*
# 配置nodejs
RUN mv /home/nodejs /usr/local/lib
# 脚本赋权
RUN chmod +x /home/dataway/application.sh
RUN chmod +x /home/docker-entrypoint.sh
RUN chmod +x /usr/local/lib/nodejs/bin/node
# 改变工作路径
WORKDIR /usr/local/tomcat/webapps
ENTRYPOINT ["sh","/home/docker-entrypoint.sh"]
