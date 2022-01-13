# 前端日志系统镜像
> 直面用户的日志记录及汇总系统！

## 一、快速开始
### 1. 新建一个数据库
```sql=
create schema logfv collate utf8_general_ci;
```
### 2. 修改通信方式为http
`vi /etc/docker/daemon.json`

在这个文件中添加如下内容：
```json
{
  "insecure-registries" : ["192.168.126.19:85"]
}
```
重启docker服务
```bash
systemctl daemon-reload
systemctl restart docker
```
### 3. 启动容器
```bash=
docker run -d -p 9999:8080 -p 9191:9191 -e DB_HOST=<dbhost> -e DB_NAME=<dbname> -e DB_PASSWD=<password> -e BASE_API=<baseapi> 192.168.126.19:85/logfv/logfv:v1
# 以下参数替换
# <dbhost> 
# <dbname>
# <password>
# <baseapi>
```
### 4. 访问系统

* 日志查询界面：http:/192.168.1.1:9999/logfv
* <span style='color:red'>日志上报接口：http://192.168.1.1:9999/logfv-server/logfv/web/upload </span>
* 后端接口：http://192.168.1.1:9191/dataway-api/api

**说明** 192.168.1.1 请换成实际IP地址

## 二、使用docker-compose
```bash=
version: "3"
services:
  logfv:
    image: 192.168.126.19:85/logfv/logfv:v1.0
    container_name: logfv-app
    environment:
      - DB_HOST=192.168.1.1
      - DB_NAME=logfv
      - DB_PASSWD=123456
      - BASE_API=http://192.168.1.1:9090
    networks:
      - logfv-tier
    ports:
      - "9999:8080"
      - "9191:9191"
    restart: always

networks:
  logfv-tier:
    driver: bridge

```

## 三、镜像参数表

|参数|是否可选|说明|默认值|
|:---|:---:|:---|:---|
|DB_HOST|必要参数|数据库地址||
|DB_NAME|必要参数|数据库名称||
|DB_PASSWD|必要参数|数据库密码||
|BASE_API|必要参数|后端地址||
|DB_PORT|可选参数|数据库端口|3306|
|DB_USER|可选参数|数据库用户名|root|
|URL_PATH|可选参数|系统路径|logfv|

## 四、前端组件
* [logfv-web](http://192.168.126.25/npm/-/web/detail/@dpark/logfv-web)
* [logfv-web-vue](http://192.168.126.25/npm/-/web/detail/@dpark/logfv-web-vue)

组件的使用请参考相应的README。

## 五、使用的技术
* javascript
* vue2
* mysql:5.7
* dataway
* java/jdk1.8
