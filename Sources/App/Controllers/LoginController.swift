import Vapor
import HTTP
import VaporJWT
import Foundation
import VaporPostgreSQL

final class LoginController {
    func login(_ req: Request) throws -> ResponseRepresentable {
        guard let param_name = req.textplain_json?.node["name"]?.string,let param_pwd = req.textplain_json?.node["pwd"]?.string else{
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
             throw Abort.custom(status: .notFound, message: "文件未找到")
        }
//        let dateFormatter = DateFormatter()
        
//        dateFormatter.dateFormat = "yyyyMMddHH:mm:ss"
        let date =  Int(Date().timeIntervalSince1970)
//        var date_string = dateFormatter.string(from: date)
        var file_save_name = "\(date)"
        let separates =  fileName.components(separatedBy: ".")
        if separates.count>1 {
            if let extension_name = separates.last {
                file_save_name = "\(file_save_name).\(extension_name)"
            }
        }
        let imagePath = "upload_images/\(file_save_name)"
        let savePath = drop.workDir + "Public/" + imagePath
        
//        try Data(file.data).write(to: URL(fileURLWithPath: "/Users/wulong/Desktop/\(date_string)"))
        let flag = FileManager.default.createFile(atPath: savePath, contents: Data(bytes: file.data), attributes: nil)
        if flag {
            return try responseWithSuccess(data: ["path":imagePath])

        }else{
            throw Abort.custom(status: .notFound, message: "保存失败")

        }
    }
}


