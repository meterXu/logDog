# vue日志组件
> 适用于vue框架的日志组件！

## 1. 如何安装sdk

```bash=
npm i logdog-web-vue
```
或
```bash=
yarn add logdog-web-vue
```

## 2. 初始化

**initConfig(globalConfig)**

* 该方法为 Logdog 单例设定全局配置。一般情况下只需在引入 Logdog 后执行一次该方法，设定好全局参数即可。
* 该方法每次被调用时，都会覆盖现有的 Logdog 全局配置。
* 该方法不是必要的，以下配置参数也都是可选的。


**globalConfig: 主要的参数配置。**

| 参数         | 说明 | 是否可选 | 默认值 |
| ------------ | ---- | -------- | -------- |
| reportUrl    |  用于接收上报日志的服务器地址。如果在调用 report 方法时也配置了 reportUrl，会优先采用那个地址进行上报。    | 否     |http://192.168.126.25/logdog-server/logdog/web/upload|
| appId|系统标识\命名空间，用于和其他系统记录的日志进行区分|否||
| appName|系统名称|否||

**其他可选参数**

| 参数         | 说明 | 是否可选 | 默认值 |
| ------------ | ---- | -------- | -------- |
|reportConfig|日志上报的配置，如果不配置，则使用默认配置，默认自动上报1天内的数据|是| |
| objType    | 使用日志组件的系统类型，1：系统，2：组件   | 是     | 1 |
| publicKey    | 1024 位的 RSA 加密公钥. 如果你需要调用 logWithEncryption() 方法对本地日志进行加密操作，那么你必须事先配置该公钥。与该公钥配对的私钥存储于你的服务器上。     | 是     | null |
| logTryTimes  |   Logdog 在遇到本地存储失败的情况下，会尝试的次数。默认为 3 次。如果 logdog 存储失败了 logTryTimes 次数后将不再进行后续日志的存储。   | 是     | 3 |
| dbName       | 你可以配置该项来自定义本地 DB 库的名字。默认为 logdog_db_{appName}。不同DB 库之间的数据是隔离而不受影响。     | 是     | logdog_db_{appName} |
| errorHandler |  你可以配置该项来接收 log() 和 logWithEncryption() 方法可能产生的异常. logdog 的 log 及 logWithEncryption 方法在底层会执行异步存储，因此你无需等待这两个方法的返回。如果你确实想知道 logdog 在存储时是否报错了，你可以配置该方法来获取异常。    | 是     | null |
| succHandler             |  你可以配置该项回调，该方法会在 log() 和 logWithEncryption() 方法内异步存储日志成功后执行。    |     是     |null|
|frameConfig|组件扩展配置，配置一些全局的日志记录功能|是| |
| console|是否在控制台同步打印日志，默认false|是| false |
| enable|是否记录日志，默认true|是| true |

**reportConfig: 主要上报参数配置**

| 参数  | 说明  | 是否可选 | 默认值 |
| --- | --- | --- | --- |
| fromDayString    |   上报该天及之后的日志，YYYY-MM-DD 格式。  | 否 | |
|toDayString|上报该天及之前的日志，YYYY-MM-DD 格式.|否| |
| days    |   上报几天内的日志，如果上传特定时间的日志，则使用fromDayString，toDayString。fromDayString和toDayString优先级高于days | 否 | 1 |
| interval             |     自动上报频率，默认3600秒（1小时）| 否   |3600秒|                                                                                                               |    否     |

**其他可选参数**

| 参数  | 说明  |类型| 是否可选 |默认值 |
| --- | --- | --- | --- |--- |
|webSource|当前上报来源，如Chrome、微信、QQ等。默认为browser|String|是|browser|
|environment|当前环境信息，如当前UA信息等。默认为navigator.userAgent|String|是|navigator.userAgent|
|customInfo|当前用户或业务附加信息。默认为null|String|是|null|
|incrementalReport|若设为false，则上报的日志将不会从本地删除。默认为true。|Boolean|是|true|

**frameConfig配置**

| 参数  | 说明  |类型| 是否可选 |默认值|
| --- | --- | --- | --- |--- |
|global|全局监听事件的触发，记录用户的操作，默认true|Boolean|是|true|
|error|全局监听未捕获的异常，记录错误信息，默认true|Boolean|是|true|
|pageview|全局监听页面的访问，记录页面变化，路由变化，默认true|Boolean|是|true|
|userview|全局监听站点访问的用户，记录ip地址，默认true|Boolean|是|true|


**示例代码**

全局安装

```javascript=
import vueLogDog from 'logdog-web-vue';
Vue.use(vueLogDog,{
  reportUrl: 'http://xxxx.xxxx.xxxx/logdog-server/logdog/web/upload',
  appId:"appId",
  appName:"appName"
})

// 组件中使用
this.$logdog.info('content')
```

覆盖默认日志上报时间

```javascript=
import vueLogDog from 'logdog-web-vue';
Vue.use(vueLogDog,{
  reportUrl: 'http://xxxx.xxxx.xxxx/logdog-server/logdog/web/upload',
  appId:"appId",
  appName:"appName"
  reportConfig:{
     days:1
  }// 上报一天内的日志
})
```


记录日志并加密

```javascript=
import vueLogDog from 'logdog-web-vue';
//初始化
Vue.use(vueLogDog,{
    reportUrl: 'https://yourServerAddressToAcceptLogs',
    appId:"appId",
    appName:"appName"
})
//记录日志并加密
this.$logdog.infpWithEncryption('confidentialLogContent');
```

记录日志并附带用户信息

```javascript=
import vueLogDog from 'logdog-web-vue';
//初始化
Vue.use(vueLogDog,{
    reportUrl: 'https://yourServerAddressToAcceptLogs',
        appId:"appId",
        appName:"appName"
        reportConfig:{
     	  webSource:'chrome',
          environment:()=>{return navigator.userAgent.toLowerCase()},
          customInfo:()=>{return document.cookie)}   
        }
})
//记录日志并附带额外信息
this.$logdog.info('confidentialLogContent');
```

## 3. 记录日志

**log(content, logType)**

| 参数    | 说明 | 是否可选 |
| ------- | ---- | -------- |
| content |  日志内容    |     否     |
| logType        | 日志类型。日志类型用于日志分类，便于你对已上报的日志内容进行分类查看。组件已经定义了如下8种日志类型。你也可以自己定义需要的日志类型。     |     否     |

**内置的日志类型**

1. action 操作日志
2. page 组件生命周期日志
3. network 网络日志
4. exception 未捕捉的错误日志
5. info 消息类、描述类日志
6. warn 警告类日志
7. debug 调试类日志
8. error 错误日志

**info(content)**

**warn(content)**

**debug(content)**

**error(content)**

| 参数    | 说明 | 是否可选 |
| ------- | ---- | -------- |
| content |  日志内容    |     否     |


**加密记录日志**

**logWithEncryption(content, logType)**

| 参数    | 说明 | 是否可选 |
| ------- | ---- | -------- |
| content |  日志内容    |     否     |
| logType        | 日志类型。日志类型用于日志分类，便于你对已上报的日志内容进行分类查看。组件已经定义了8种日志类型。你也可以自己定义需要的日志类型。     |     否     |


**infoWithEncryption(content)**

**warnWithEncryption(content)**

**debugWithEncryption(content)**

**errorWithEncryption(content)**

| 参数    | 说明 | 是否可选 |
| ------- | ---- | -------- |
| content |  日志内容    |     否     |


* 使用 log() 方法落地的日志接近于明文存储，任何有办法触达该用户端的人都能够获取到本地日志。
* 如果你期望一些日志内容加密后再落地，你可以调用该方法。
* logdog 使用对称加密结合非对称加密的方式来保障本地日志安全。日志内容会使用 AES 进行加密，同时 AES 加密时使用的对称密钥会使用 RSA 进行非对称加密，加密后的密钥密文会和日志密文一起落地下来。


> 需要注意的是：虽然使用该方法存储后的日志很难再被破解，但是不能保证你的日志内容在存储之前不被窃听。另外由于在用户端加密以及在服务端解密都更耗费时间且可能引起性能问题，所以建议你只在日志内容敏感的必要时候使用该方法。


用法：

记录普通日志

```javascript=
import vueLogDog from 'logdog-web-vue';
this.$logdog.info('登录系统成功')
```

记录错误日志

```javascript=
import vueLogDog from 'logdog-web-vue';
this.$logdog.error(`数据id为空，无法更新，数据内容：${JSON.parse(data)}`)
```

记录错误日志，并附带相关数据

```javascript=
import vueLogDog from 'logdog-web-vue';
this.$logdog.error(`数据id为空，无法更新，数据内容：${JSON.parse(data)}`)
```
