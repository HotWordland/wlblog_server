//
//  ArticleController.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/13.
//
//

import Vapor
import HTTP
import Foundation
import VaporPostgreSQL

//文章管理 Restful
final class ArticleController:ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try Article.all().makeNode().converted(to: JSON.self)
    }
    func get_limit_index(_ req: Request) throws -> ResponseRepresentable{
        if let mysql = drop.database?.driver as? PostgreSQLDriver {
            if let page  = req.textplain_json?.node["start"]?.int {
                if let count_r = try? mysql.raw("SELECT count(*) FROM articles"){
                    if let array = count_r.array,let count_obj = array[0].object, let count_obj_dic = count_obj["count"],let count = count_obj_dic.int {
                        print("共有 \(count) 条数据")
                        var single_count = 5
                        if let single_count_param  = req.textplain_json?.node["single_count"]?.int {
                            single_count = single_count_param
                        }
                        let count_page = ceil(Double(count)/Double(single_count))
                        print("每页 \(single_count) 条数据 , 共有 \(Int(count_page)) 页")
                        let offset = page*single_count
                        let all = try mysql.raw("SELECT * FROM articles LIMIT \(single_count) OFFSET \(offset)")
                        let result = Node(["list":all,"pages":Node(Int(count_page))])
                        print(result)
                        return try responseWithSuccess(data: ["list":all,"pages":Node(Int(count_page))])
                    }
                    //                    if let count = count_r.array?[0].object?["count"]?.int{
                    //                    }
                }
                
            }
        }
        return try responseWithError(msg: "")
        
    }
    func create(request: Request) throws -> ResponseRepresentable {
        var article = try request.article()
        try article.save()
        return article
    }
    
    func show(request: Request, article: Article) throws -> ResponseRepresentable {
        return article
    }
    
    func delete(request: Request, article: Article) throws -> ResponseRepresentable {
        try article.delete()
        return try responseWithSuccess(data: [:])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try Article.query().delete()
        return JSON([])
    }
    
    func update(request: Request, article: Article) throws -> ResponseRepresentable {
        let new = try request.article()
        var article = article
            article.art_title = new.art_title
        article.art_content = new.art_content
        article.art_description = new.art_description
        article.art_keywords = new.art_keywords
        article.art_tag = new.art_tag
        article.art_thumb = new.art_thumb
        article.art_time = new.art_time
        article.art_editor = new.art_editor
        article.art_view = new.art_view
        article.catagory_id = new.catagory_id

        try article.save()
        return article
    }
    
    func replace(request: Request, article: Article) throws -> ResponseRepresentable {
        try article.delete()
        return try create(request: request)
    }
    
    func makeResource() -> Resource<Article> {
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
    func article() throws -> Article {
        guard let json = textplain_json else { throw Abort.badRequest }
        return try Article(node: json)
    }
}
