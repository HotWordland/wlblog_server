//
//  Catagory.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/6.
//
//

import Vapor
import Foundation
final class Catagory : Model {
    var id : Node? //database column id
    
    var cate_name : String
    var cate_title : String
    var cate_description : String
    var cate_keywords : String
    var cate_view : String
    var cate_order : String
    var cate_pid : String

    
    /**
     Whether or not entity was retrieved from database.
     
     This value shouldn't be interacted w/ external users
     w/o explicit knowledge.
     
     General implementation should just be `var exists = false`
     */
    var exists: Bool = false
    
    
    init(cate_name:String,cate_title:String,cate_description:String,cate_keywords:String,cate_view:String,cate_order:String,cate_pid:String) {
        self.id = UUID().uuidString.makeNode()
        self.cate_name = cate_name
        self.cate_title = cate_title
        self.cate_description = cate_description
        self.cate_keywords = cate_keywords
        self.cate_view = cate_view
        self.cate_order = cate_order
        self.cate_pid = cate_pid
    }
    //取出
    init(node: Node, in context: Context) throws {
        self.id = try node.extract("id")
        self.cate_name = try node.extract("cate_name")
        self.cate_title = try node.extract("cate_title")
        self.cate_description = try node.extract("cate_description")
        self.cate_keywords = try node.extract("cate_keywords")
        self.cate_view = try node.extract("cate_view")
        self.cate_order = try node.extract("cate_order")
        self.cate_pid = try node.extract("cate_pid")
        
    }
    //实现协议 json化 等
    func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            "id":id,
            "cate_name":cate_name,
            "cate_title":cate_title,
            "cate_description":cate_description,
            "cate_keywords":cate_keywords,
            "cate_view":cate_view,
            "cate_order":cate_order,
            "cate_pid":cate_pid,
            ])
    }
    // 第一次从数据库准备 对应表
    static func prepare(_ database: Database) throws {
        try database.create("catagorys", closure: { (user) in
            user.id()
            user.string("cate_name")
            user.string("cate_title")
            user.string("cate_description")
            user.string("cate_keywords")
            user.string("cate_view")
            user.string("cate_order")
            user.string("cate_pid")
        })
    }
    // drop delete table
    static func revert(_ database: Database) throws {
        try database.delete("catagorys")
    }
}
