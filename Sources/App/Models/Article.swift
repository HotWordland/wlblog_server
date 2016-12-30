//
//  Article.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/13.
//
//
import Foundation
import Vapor
import Fluent
final class Article : Model{

    var id : Node? //database column id
    
    var art_title : String
    var art_content : String
    var art_description : String
    var art_keywords : String
    var art_tag : String
    var art_thumb : String
    var art_time : String
    var art_editor : String
    var art_view : String
    var catagory_id : Node?  //关联外键 分类列表
    
    /**
     Whether or not entity was retrieved from database.
     
     This value shouldn't be interacted w/ external users
     w/o explicit knowledge.
     
     General implementation should just be `var exists = false`
     */

    var exists: Bool = false
    
    init(art_title:String,art_content:String,art_description:String,art_keywords:String,art_tag:String,art_thumb:String,art_time:String,art_editor:String,art_view:String) {
        self.id = UUID().uuidString.makeNode()
        self.art_title = art_title
        self.art_content = art_content
        self.art_description = art_description
        self.art_keywords = art_keywords
        self.art_tag = art_tag
        self.art_thumb = art_thumb
        self.art_time = art_time
        self.art_editor = art_editor
        self.art_view = art_view
//        self.cate_id = cate_id

    }
    //取出
    init(node: Node, in context: Context) throws {
        self.id = try node.extract("id")
        self.art_title = try node.extract("art_title")
        self.art_content = try node.extract("art_content")
        self.art_description = try node.extract("art_description")
        self.art_keywords = try node.extract("art_keywords")
        self.art_tag = try node.extract("art_tag")
        self.art_thumb = try node.extract("art_thumb")
        self.art_time = try node.extract("art_time")
        self.art_editor = try node.extract("art_editor")
        self.art_view = try node.extract("art_view")
        self.catagory_id = try node.extract("catagory_id")

        
    }
    //实现协议 json化 等
    func makeNode(context: Context) throws -> Node {
        return try Node(node:[
            "id":id,
            "art_title":art_title,
            "art_content":art_content,
            "art_description":art_description,
            "art_keywords":art_keywords,
            "art_tag":art_tag,
            "art_thumb":art_thumb,
            "art_time":art_time,
            "art_editor":art_editor,
            "art_view":art_view,
            "catagory_id":catagory_id
            ])
    }
    // 第一次从数据库准备 对应表
    static func prepare(_ database: Database) throws {
        try database.create("articles", closure: { (art) in
            art.id()
            art.string("art_title")
            art.string("art_content") //暂时需要用postgresql设置其类型为text
            art.string("art_description")
            art.string("art_keywords")
            art.string("art_tag")
            art.string("art_thumb")
            art.string("art_time")
            art.string("art_editor")
            art.string("art_view")
            art.parent(Catagory.self, optional: false)

        })
    }
    // drop delete table
    static func revert(_ database: Database) throws {
        try database.delete("articles")
    }

}
extension Article{
    func owner() throws -> Parent<Catagory> {
        return try parent(catagory_id)
    }

}
