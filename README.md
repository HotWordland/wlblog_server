## 线上访问
http://wlpsv.com:8081/wlblog_admin_front/admin/#/login
用户名:admin2
密码:123456
## 基本功能
- vapor构建(swift服务端框架).
- Api服务.
- JWT支持.
- postgresql数据库操作. 


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
vapor xcode \\生成xcode工程 这里会开始安装swift package依赖
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
## 💧 Community

Join the welcoming community of fellow Vapor developers in [slack](http://vapor.team).

## 🔧 Compatibility

This package has been tested on macOS and Ubuntu.
