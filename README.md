# 前端日志工具

**系统组成**

| 名称        | 作用                 |说明|
| ----------- | -------------------- | -------------------- |
| Web SDK     | sdk                  |[webSDK](./webSDK)|
| 后台server  | 接收、存储、分析日志 |[Server](./server)|
| 前台Web     | 展示，查询日志       |[s2-logfv-site](./s2-logfv-site)|
| docker部署| 一键docker部署       |[deployments](./deployments)|
## 一、手动部署
### 1、数据库

* 建库脚本
```sql=
create schema logfv collate utf8_general_ci;
```
* 表结构脚本：`deployments\dbInit\dbsql\schema.sql`
* 表数据脚本：`deployments\dbInit\data.sql`
* 更新脚本：`deployments\dbInit\update.sql`

### 2、后端
**上报服务**

1. 拷贝logfv-server.war至服务的tomcat的webapps目录下
2. 修改数据库配置
```
logfv-server\WEB-INF\classes\db.properties.production
```
**管理工具后端**
1. 拷贝dataway至服务器
2. 修改数据库配置
```
dataway\config\application-prod.yml
```

### 3、前端
1. 拷贝s2-logfv至nginx的html目录
2. 修改配置文件
```
s2-logfv\project.js
后端地址(baseApi)一般为：http://xxx:9191/dataway-api/api
```

## 二、docker部署
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
docker run -d -p 9999:8080 -p 9191:9191 -e DB_HOST=<dbhost> -e DB_NAME=<dbname> -e DB_PASSWD=<password> -e BASE_API=<baseapi> 192.168.126.19:85/logfv/logfv:latest
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

### 使用 docker-compose
```bash=
version: "3"
services:
  logfv:
    image: 192.168.126.19:85/logfv/logfv:latest
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
|TZ|可选参数|时区|Asia/Shanghai|

## 四、前端组件
* [logfv-web](http://192.168.126.25/npm/-/web/detail/@dpark/logfv-web)
* [logfv-web-vue](http://192.168.126.25/npm/-/web/detail/@dpark/logfv-web-vue)

组件的使用请参考相应的README。

## 五、使用
### 普通前端项目
1. 项目安装日志组件
```bash
yarn add @dpark/logfv-web --registry http://58.210.9.133/iplatform/npm/
```
2. 在项目中记录日志
```javascript
import Logfv from '@dpark/logfv-web';
let logfv = new Logfv({
  reportUrl: 'http://<ip>:8080/logfv-server/logfv/web/upload',
  appId:"appId",
  appName:"appName"
})

// 项目中使用
logfv.info('content')
```
### vue项目
1. 项目安装日志组件
```bash
yarn add @dpark/logfv-web-vue --registry http://58.210.9.133/iplatform/npm/
```
2. 在项目中记录日志
```javascript
import vueLogFv from '@dpark/logfv-web-vue';
Vue.use(vueLogFv,{
    reportUrl: 'http://<ip>:8080/logfv-server/logfv/web/upload', //换成自己部署的上报地址
    appId:"appId",
    appName:"appName"
})

// 组件中使用
this.$logfv.info('helloWorld')
```
详见 [前端日志组件](http://58.210.9.133/iplatform/npm/-/web/detail/@dpark/logfv-web-vue)

### 后端项目

**URL**

```
http://<ip>:8080/logfv-server/logfv/web/save
```

**Method**

```
POST
```

**请求body**

类型：application/json

```json
{
  "logDate":1644478415932,
  "type": "info",
  "appId": "demo",
  "appName": "demo系统",
  "content": "这是后端接口日志",
  "environment":"jdk 1.8",
  "info":"controller:/demo/test",
  "source": "api"
}
```

其中logDate,type,appId,appName,content必填

**返回body**

```json
{
    "code": 200,
    "success": true,
    "msg": null,
    "data": true
}
```

## 六、使用的技术
* javascript
* vue2
* mysql:5.7
* dataway
* java/jdk1.8

## 七、说明

该项目基于[logan项目](https://github.com/Meituan-Dianping/Logan) 二次开发，部分源码来自logan

