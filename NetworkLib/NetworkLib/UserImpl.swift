//
//  UserServiceImpl.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation


import ProtocolLibrary
import Alamofire
import Moya

public enum UserService {
    case info(userName: String?, _ method: HTTPMethod = .get)

}

extension UserService: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }

    public var path: String {
        switch self {
        case .info(_, _):
            return "/userinfo"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .info(_, let method):
            return method
        }
    }
    public var task: Task {
        switch self {
        case .info(_, _):
            return .requestPlain
        }
    }
    public var sampleData: Data {
        switch self {
        case .info(_, let method):
            if method == .get {
                return """
                    {"id": "ADDFSG-ASDF@#$-#$%SDFA-dddd",
                    "name": "ComponentsHub",
                    "password": "ADFGBEEBVLL",
                    "info":"A Sample Component Communication Library"}
                    """.data(using: .utf8)!
            }
            return "{code:200, message:'ok'}".data(using: .utf8)!
        }
    }
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

class UserImpl : User {

    // NOTE: 这里的 stub 表示2s内请求不成功，则返回sample data
    lazy var provider = MoyaProvider<UserService>(stubClosure:MoyaProvider.delayedStub(2), trackInflights: true)

    @discardableResult
    func getUserInfo(name: String, completion: @escaping (DemoUserModel?) -> Void) -> Cancelable {

        return provider.request(.info(userName: name)) { result in
            switch result {
            case .success(let response):
                var model: DemoUserModel?
                do {
                    model = try response.map(to: DemoUserModel.self)
                } catch let e {
                    print("catch error: \(e)")
                    completion(nil)
                    return
                }
                completion(model)
            case .failure(_):
                print("fail")
            }

            completion(nil)
        }.asCancellable()
    }

}
