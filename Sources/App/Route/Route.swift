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
        //登录
        admin.post("login",handler: loginc.login)
        //测试上传文件
        admin.post("upload",handler: loginc.uploadFile)
        //中间件 判断token
        admin.group(UserLoginMiddle()) { authorized in
            authorized.post("getuserinfo") { request in
                // has been authorized
                return try JSON(node:[
                    "token":"token prepare..."
                    ])
            }
            authorized.resource("catagory", catagoryc)
            authorized.post("catagory_index_limit", handler: catagoryc.get_limit_index)
            authorized.resource("article", articlec)
            authorized.get("getParentCatalog",handler: catagoryc.getParentCatalog)
            
        }

    }
    
    
    
    drop.post("getinfo") { req in
        return try JSON(node:[
            "status":"200"
            ]
        )
    }

}

