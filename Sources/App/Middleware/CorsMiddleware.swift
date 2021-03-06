//
//  CorsMiddleware.swift
//  wlblog
//
//  Created by 情热大陆 on 16/12/28.
//
//

import Foundation
import Vapor
import HTTP


final class CorsMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        let response: Response
        if request.uri.path.hasPrefix("/upload_images") {
            response = try next.respond(to: request)
            return response
        }
        if request.isPreflight {
            response = "".makeResponse()
        } else {
            response = try next.respond(to: request)
        }
        
        response.headers["Access-Control-Allow-Origin"] = request.headers["Origin"] ?? "*";
        response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, Origin, Content-Type, Accept, Authorization"
        response.headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, OPTIONS, DELETE, PATCH"
        return response
    }
}

extension Request {
    var isPreflight: Bool {
        return method == .options
            && headers["Access-Control-Request-Method"] != nil
    }
}
