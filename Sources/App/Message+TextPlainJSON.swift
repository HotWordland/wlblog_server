//
//  Message+TextPlainJSON.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/30.
//
//

import HTTP
import Vapor
extension Message {
    //vapor作为api服务器时 angular跨域方案
    public var textplain_json: JSON? {
        get {
            if let type = headers["Content-Type"], type.contains("text/plain") {
                guard case let .data(body) = body else { return nil }
                guard let json = try? JSON(bytes: body) else { return nil }
                storage["json"] = json
                return json
            } else {
                return nil
            }
        }
        
    }
}
