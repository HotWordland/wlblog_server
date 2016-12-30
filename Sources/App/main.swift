import Vapor
import VaporPostgreSQL

//let drop = Droplet(preparations:[User.self]
//    ,providers:[VaporPostgreSQL.Provider.self])
let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations+=User.self
drop.preparations+=Catagory.self
drop.preparations+=Article.self


//配置路由
configRoute(drop: drop)



drop.run()
