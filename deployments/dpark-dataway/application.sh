#!/bin/bash

APP_DIR=.
APP_NAME=dpark-dataway
#PROFILES_ACTIVE=$2
#iAPP_CONF=$APP_DIR/application.properties
APP_CONF=config/application.yml

if [ "$1" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi

#if [ "$PROFILES_ACTIVE" = "" ];
#then
    #echo -e "\033[0;31m 未输入执行的环境 \033[0m \033[0;34m {dev|prod} \033[0m"
    #exit 1
#fi

function start()
{
    count=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`
    if [ $count != 0 ];then
        echo "$APP_NAME is running..."
    else
        nohup java -Xms10m -Xmx200m -jar -Dspring.config.location=./config/application.yml,./config/application-prod.yml $APP_DIR/"$APP_NAME".jar  > $APP_DIR/logs/"$APP_NAME".log 2>&1 &
        echo $! > $APP_DIR/tpid
    echo "Start $APP_NAME success..."
    fi
}

function stop()
{
    echo "Stop $APP_NAME"
    boot_id=`ps -ef |grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'`
    count=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`

    if [ $count != 0 ];then
        kill $boot_id
        count=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`

        boot_id=`ps -ef |grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'`
        kill -9 $boot_id
    fi
}

function restart()
{
    stop
    sleep 2
    start
}

function status()
{
    count=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`
    if [ $count != 0 ];then
        echo "$APP_NAME is running..."
    else
        echo "$APP_NAME is not running..."
    fi
}

case $1 in
    start)
    start;;
    stop)
    stop;;
    restart)
    restart;;
    status)
    status;;
    *)
esac
