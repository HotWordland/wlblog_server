import Vapor
import HTTP
import VaporJWT
import Foundation
import VaporPostgreSQL

final class LoginController {
    func login(_ req: Request) throws -> ResponseRepresentable {
        guard let param_name = req.data["name"]?.string,let param_pwd = req.data["pwd"]?.string else{
            return try responseWithError(msg: "有未提交的参数")
        }
        guard let user = try User.query().filter("name",param_name).all().first else{
            return try responseWithError(msg: "用户不存在")
        }
        if user.password != param_pwd {
            return try responseWithError(msg: "密码有误")
        }
        let jwt = try JWT(payload: Node(ExpirationTimeClaim(Date() + 60)),
                          signer: HS256(key: "secret"))
        let token = try jwt.createToken()
        return try responseWithSuccess(data: ["token":token])
    }
    func saveDefaultUser(_ req: Request) throws -> ResponseRepresentable {
        if  try User.query().filter("name","admin2").all().count != 0 {
          return try responseWithError(msg: "admin2 aleady exsit")
        }
        var user = User(name: "admin2", password: "123456")
        try user.save()
        return try JSON(node:User.all().makeNode())
    }
    func uploadFile(_ request: Request) throws -> ResponseRepresentable{
        guard let file = request.multipart?["file"]?.file,let fileName = file.name else {
            return "Not found"
        }
        try Data(file.data).write(to: URL(fileURLWithPath: "/Users/wulong/Desktop/\(fileName)"))
        return try responseWithSuccess(data: [:])

    }
}


