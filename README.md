# 前端日志工具

**工具组成**

| 名称        | 作用                 |说明|
| ----------- | -------------------- | -------------------- |
| Web SDK     | sdk                  |[webSDK](./webSDK)|
| 后台server  | 接收、存储、分析日志 |[Server](./Server)|
| 前台Web     | 展示，查询日志       |[s2-logfv-site](./s2-logfv-site)|
| docker部署| 一键docker部署       |[deployments](./deployments)|

## 手动部署
### 1、数据库

初始化
```sql=
create schema logfv collate utf8_general_ci;
```
数据库初始化脚本：`initDB.sql`

### 2、后端
**上报服务**

1. 拷贝logfv-server.war至服务的tomcat的webapps目录下
2. 修改数据库配置
```
logfv-server\WEB-INF\classes\db.properties.production
```
**管理工具后端**
1. 拷贝dpark-dataway至服务器
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

## docker部署
### 修改通信方式为http
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
### docker-compose
```yaml
version: "3"
services:
  logfv:
    image: 192.168.126.19:85/logfv/logfv:v1.0
    container_name: logfv-app
    environment:
      - DB_HOST=<dbhost>
      - DB_NAME=<dbname>
      - DB_USER=<dbsuer>
      - DB_PASSWD=<dbpasswd>
      - BASE_API=<baseapi>
    networks:
      - logfv-tier
    ports:
      - "8080:8080"
      - "9191:9191"
    restart: always

networks:
  logfv-tier:
    driver: bridge
```
`<dbhost>，<dbname>，<dbsuer>，<dbsuer>，<dbpasswd>，<baseapi>`参数改成真实值。

详见 [docker部署](./deployments)

## 使用
1. 项目安装日志组件
```bash=
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
详见 [前端日志组件](./webSDK)
