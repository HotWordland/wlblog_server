//
//  RequestState.swift
//  wlblog
//
//  Created by 巫龙 on 2016/12/5.
//
//

import Foundation
import Vapor


func responseWithSuccess(status:String = "200",data:[String:Node],msg:String = "操作成功") throws -> JSON{
    return try JSON(node:[
        "status":status,
        "data":JSON(node:data),
        "msg":msg
        ])

}
func responseWithError(status:String = "300",data:[String:Node] = ["":Node("")],msg:String) throws -> JSON{
    return try JSON(node:[
        "status":status,
        "data":JSON(node:data),
        "msg":msg
        ])
    
}
func responseWithAuthFail(status:String = "301",data:[String:Node] = ["":""],msg:String="") throws -> JSON{
    return try JSON(node:[
        "status":status,
        "data":JSON(node:data),
        "msg":msg
        ])
    
}
