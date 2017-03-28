import Vapor
import VaporPostgreSQL

//let drop = Droplet(preparations:[User.self]
//    ,providers:[VaporPostgreSQL.Provider.self])
let drop = Droplet()
drop.middleware = [CorsMiddleware()] // cors 设置
/* 版本之前的 cors 设置代码
 let drop = Droplet(
 availableMiddleware: ["cors" : CorsMiddleware()],
 serverMiddleware: ["file", "cors"],
 preparations: [Todo.self],
 providers: [VaporMySQL.Provider.self]
 )
 */
try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations+=User.self
drop.preparations+=Catagory.self
drop.preparations+=Article.self

//测试一下数据连接 
if let postgresql = drop.database?.driver as? PostgreSQLDriver {
    let all = try postgresql.raw("SELECT * FROM catagorys")
    print(all)
}

//配置路由
configRoute(drop: drop)


drop.run()


