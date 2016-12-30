//
//  Route.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/5.
//
//

import Vapor

func configRoute(drop:Droplet) -> Void {
    drop.get("admin") { req in
        return try drop.view.make("main")
    }
    let loginc = LoginController()
    let catagoryc = CatagoryController()
    let articlec = ArticleController()
    drop.get("saveDefaultUser",handler: loginc.saveDefaultUser)
    
    
    drop.group("admin/api") { admin in
        //CorsMiddleware
        admin.group(CorsMiddleware()) { cors_authorized in
        //登录
        cors_authorized.post("login",handler: loginc.login)
        //测试上传文件
        cors_authorized.post("upload",handler: loginc.uploadFile)
        //中间件 判断token
        cors_authorized.group(UserLoginMiddle()) { authorized in
            authorized.post("getuserinfo") { request in
                // has been authorized
                return try JSON(node:[
                    "token":"token prepare..."
                    ])
            }
            cors_authorized.resource("catagory", catagoryc)
            cors_authorized.resource("article", articlec)
            cors_authorized.get("getParentCatalog",handler: catagoryc.getParentCatalog)
            
        }
        }
    }
    
    
    
    drop.post("getinfo") { req in
        return try JSON(node:[
            "status":"200"
            ]
        )
    }

}

