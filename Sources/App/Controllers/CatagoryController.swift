//
//  CatagoryController.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/6.
//
//

import Vapor
import HTTP
import VaporJWT
import Foundation
import VaporPostgreSQL
//分类管理 Restful
final class CatagoryController:ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
//        let result = try Catagory.query().sort("cate_view",.ascending).all() 这里没有生效估计是因为建立的字段是String的关系 没关系 我们用swift原生来写
//        var all = try Catagory.all()
//        all = all.sorted { (p_c1, p_c2) -> Bool in
//            guard let c1 = p_c1.cate_order.int,let c2 = p_c2.cate_order.int else{
//              return false
//            }
//            //返回升序
//            return c1<c2
//        }
//        return try all.makeNode().converted(to: JSON.self)
        if let mysql = drop.database?.driver as? PostgreSQLDriver {
            let all = try mysql.raw("SELECT * FROM catagorys")
            print(all)
            return try all.converted(to: JSON.self)
        }
        return "".makeResponse()

    }
    //获取父级分类
    func getParentCatalog(request: Request) throws -> ResponseRepresentable {
        return try JSON(node:Catagory.query().filter("cate_pid","0").all().makeNode())
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var catagory = try request.catagory()
        try catagory.save()
        return catagory
    }
    
    func show(request: Request, catagory: Catagory) throws -> ResponseRepresentable {
        return catagory
    }
    
    func delete(request: Request, catagory: Catagory) throws -> ResponseRepresentable {
        try catagory.delete()
        return try responseWithSuccess(data: [:])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try Catagory.query().delete()
        return JSON([])
    }
    
    func update(request: Request, catagory: Catagory) throws -> ResponseRepresentable {
        let new = try request.catagory()
        var catagory = catagory
        catagory.cate_name = new.cate_name
        catagory.cate_title = new.cate_title
        catagory.cate_description = new.cate_description
        catagory.cate_keywords = new.cate_keywords
        catagory.cate_view = new.cate_view
        catagory.cate_order = new.cate_order
        catagory.cate_pid = new.cate_pid
        try catagory.save()
        return catagory
    }
    
    func replace(request: Request, catagory: Catagory) throws -> ResponseRepresentable {
        try catagory.delete()
        return try create(request: request)
    }
    
    func makeResource() -> Resource<Catagory> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func catagory() throws -> Catagory {
        guard let json = textplain_json else { throw Abort.badRequest }
        return try Catagory(node: json)
    }
}

