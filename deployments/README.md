# 前端日志系统镜像
## 镜像编译发说明

* build.sh 镜像编译主入口
* Dockerfile 镜像编排文件
* docker-entrypoint.sh 镜像运行入口文件
* dataway 后端接口生成服务
* dbInit 数据库初始化程序，包含数据库初始化脚本
* nodejs nodejs程序包
* Jenkinsfile Jenkins流水线配置

## 镜像编译

操作系统： ubuntu 18.04 LTS

软件环境：
```
jdk1.8
mvn>=3.8
nodejs>=14
```

命令：

```bash
sh ./build.sh
```
