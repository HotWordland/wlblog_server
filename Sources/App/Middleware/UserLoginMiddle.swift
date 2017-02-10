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
            //            throw Abort.custom(status: .notFound, message: "未发现token值")
            return try responseWithAuthFail(msg: "未发现token值").makeResponse()
        }
        //        var jwt:JWT?
        //            do{
        //                jwt = try JWT(token: param_token)
        //            }catch{
        //                throw Abort.custom(status: .notFound, message: "token无效")
        //            }
        let jwt3 = try JWT(token:param_token)
        
        //             let isValid = try jwt3.verifySignatureWith(ES256(key: "AL3BRa7llckPgUw3Si2KCy1kRUZJ/pxJ29nlr86xlm0="))
        let isValid = try jwt3.verifySignatureWith(HS256(key: "secret"))
        
        if isValid{
            
            let time_vaild = jwt3.verifyClaims([ExpirationTimeClaim()])
            if time_vaild {
                return try next.respond(to: request)
            }else{
                return try responseWithAuthFail(msg: "token已过期").makeResponse()
            }
            
        }
        throw Abort.custom(status: .notFound, message: "token无效")
        
        
    }
    
}
