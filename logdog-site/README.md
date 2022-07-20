# s2-logfv-site
> 单体前端项目，由s2前端框架进行构建。

[s2在线帮助文档](http://58.210.9.133/iplatform/pldoc)
## 初始化
* 安装s2
```
npm i -g @dpark/s2 --registry http://192.168.126.25/npm/
```
* 项目初始化
```
npm run pre
```

### 相关配置
* 配置文件：`src\project.js`
* 路由：`src\views\index.js`

* 过滤显示日志类型

```js=
// project.js
typesFilter:["info","error","other"],
```

### 运行
* 开发模式
```
npm run dev
```
* 代理模式
```
npm run proxy
```

### 编译
* 打包成模块
```
npm run build:module
```
* 打包成完整项目
```
npm run build
```
