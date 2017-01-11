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
