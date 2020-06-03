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
    case info(info: String?, _ method: HTTPMethod = .get)

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
        case .info(_, _):
            return "{key: value}".data(using: .utf8)!
        }
    }
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

class UserImpl : User {

    lazy var provider = MoyaProvider<UserService>()

    func getUserInfo(completion: @escaping () -> Void) -> Cancelable {

        return provider.request(.info(info: nil, .get)) { result in
            switch result {
            case .success(let response):
                print("success")
            case .failure(let error):
                print("fail")
            }

            completion()
        }.asCancellable()
    }

}
