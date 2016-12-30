//
//  UserLoginMiddle.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/5.
//
//

import Foundation
import Vapor
import HTTP
import VaporJWT
final class UserLoginMiddle: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {

            guard let param_token = request.headers["Authorization"]  else {
                throw Abort.custom(status: .notFound, message: "未发现token值")
            }
        var jwt:JWT?
            do{
                jwt = try JWT(token: param_token)
            }catch{
                throw Abort.custom(status: .notFound, message: "token无效")
            }
        do{
            guard let isValid = try jwt?.verifySignatureWith(HS256(key: "secret")) else{
                throw Abort.custom(status: .notFound, message: "token无效")
            }
            if isValid{
                return try next.respond(to: request)
            }
            throw Abort.custom(status: .notFound, message: "token无效")


        }catch{
            throw Abort.custom(status: .notFound, message: "系统正忙")
        }
        }

}
