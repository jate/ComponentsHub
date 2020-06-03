//
//  GithubServiceImpl.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ProtocolLibrary
import Moya
import SwiftyJSON

enum GithubService {
    case searchReposities(query: String)
}

extension GithubService: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }

    public var path: String {
        switch self {
        case .searchReposities( _):
            return "/search/repositories"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .searchReposities( _):
            return .get
        }
    }
    public var task: Task {
        switch self {
        case .searchReposities(let query):
            return .requestParameters(parameters: ["q": "\(query)"], encoding: URLEncoding.queryString)
        }
    }
    public var sampleData: Data {
        switch self {
        case .searchReposities( _):
            return "{key: value}".data(using: .utf8)!
        }
    }
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

class GithubImpl : Github {

    lazy var provider = MoyaProvider<GithubService>()

    @discardableResult
    func searchReposities(query: String, completion: @escaping ([GithubReposityItem]) -> Void) -> Cancelable {

        return provider.request(.searchReposities(query: query)) { result in
            switch result {
            case .success(let response):

                var model: GithubReposityModel?
                do {
                    model = try response.filterSuccessfulStatusCodes().map(to: GithubReposityModel.self)
                } catch {
                    completion([])
                    return
                }
                completion(model!.items)
                return
            case .failure(_):
                print("fail")
            }
            completion([])
        }.asCancellable()
    }

}
