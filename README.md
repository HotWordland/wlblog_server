## 线上访问
http://wlpsv.com:8081/wlblog_admin_front/admin/#/login
用户名:admin2
密码:123456

## Xcode preview
 ![](https://github.com/HotWordland/wlblog_server/blob/master/00.jpeg)
 
# 截图
 ![](https://github.com/HotWordland/wlblog_server/blob/master/01.jpeg)
 ![](https://github.com/HotWordland/wlblog_server/blob/master/02.jpeg)
 ![](https://github.com/HotWordland/wlblog_server/blob/master/03.jpeg)
 ![](https://github.com/HotWordland/wlblog_server/blob/master/04.jpeg)
 ![](https://github.com/HotWordland/wlblog_server/blob/master/05.jpeg)



## 基本功能
- vapor构建(swift服务端框架).
- Api服务.
- JWT支持.
- postgresql数据库操作. 

## 结构
 ![](https://github.com/HotWordland/wlblog_server/blob/master/struct.png)

## 📖 安装



获取vapor
```
curl -sL check.vapor.sh | bash
```
安装完成之后 我们再安装vapor 的toolbox(工具)

```
curl -sL toolbox.vapor.sh | bash
```
这里稍微说一下 如果用这个命令没能安装完成 报错 可以通过brew的形式来安装 https://github.com/vapor/toolbox
如果这样也没能安装成功 
这里提供一下手动安装的处理方式:
```
git clone https://github.com/vapor/toolbox.git
cd toolbox/
swift build -c release
./.build/release/Executable self install
```
cd到项目根目录 安装swift package 依赖
```
vapor xcode //生成xcode工程 这里会开始安装swift package依赖
```

配置postgresql
```
brew update

brew install postgres
```
成功后启动
```
postgres -D /usr/local/var/postgres
```
可能出现问题 '/usr/local/var/postgres' 无此路径的解决方法 mac os 10.11
```
# sudo mkdir /usr/local/var/postgres
# sudo chmod 775 /usr/local/var/postgres
# sudo chown construct /usr/local/var/postgres
# initdb /usr/local/var/postgres	use your username in place of construct. So, if your computer username is WDurant, the code will be:	
# sudo chown wdurant /usr/local/var/postgres
```
创建数据库
```
createdb `whoami` //创建一个本机用户名的名字的数据库
```
clone项目后 修改项目根目录下的 /Config/secrets/postgresql.json
```
{
    "host": "127.0.0.1",
    "user": your_computer_name,
    "password": "",
    "database": your_create_database_name,//即为 createdb `whoami` //创建一个本机用户名的名字的数据库
    "port": 5432
} 
```
导入数据

将项目根目录下的public.sql文件导入进数据库 运行xcode即可 运行成功后会看到 标题 xcode preview 第一张图 显示的控制台信息
由于设计原因项目只提供api服务 没有用到vapor的模板引擎 测试api或者查看路径 可以到线上环境查看网络请求情况 相对路径跟本地是一样的
后面会提供api图

## 💧 其他
vapor 现在已经更新到2.0beta了 项目使用的是1.3版本 后期会升级更新

管理后台前端部分目前采用的是angularjs 由于angularjs(1.x)一直找不到合适脚手架管理工具加上已经有angular2 vue也用了一段时间了 
所以接下来会用vue2重写

一些题外话 : 
也可以和笔者进行交流 qq群 318042857 验证信息:vapor交流 网站:https://codercq.com
项目比较简单 上手很适合 目前vapor可以在Ubuntu上跑 所以拿来玩玩还是不错的 也可以写一些自己小的项目 另外最近Perfect也在盛行 星星数已经超过
vapor了 对于喜欢swift的朋友也是好消息 喜欢swift的赶紧入坑吧 ^_^




