//
//  User.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/5.
//
//

import Vapor
final class User : Model {
    var id : Node? //database column id
    
    var name : String
    var password : String
    
    /**
     Whether or not entity was retrieved from database.
     
     This value shouldn't be interacted w/ external users
     w/o explicit knowledge.
     
     General implementation should just be `var exists = false`
     */
    var exists: Bool = false
    
    
    init(name:String,password:String) {
        self.name = name
        self.password = password
    }
    //取出
    init(node: Node, in context: Context) throws {
        self.id = try node.extract("id")
        self.name = try node.extract("name")
        self.password = try node.extract("password")
        
    }
    //实现协议 json化 等
    func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            "id":id,
            "name":name,
            "password":password
            ])
    }
    // 第一次从数据库准备 对应表
    static func prepare(_ database: Database) throws {
        try database.create("users", closure: { (user) in
            user.id()
            user.string("name")
            user.string("password")
        })
    }
    // drop delete table
    static func revert(_ database: Database) throws {
        try database.delete("users")
    }
}
