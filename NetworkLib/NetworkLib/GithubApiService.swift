//
//  GithubApiService.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import Dispatch

import ProtocolLibrary

class GithubApiService : NetApiProtocol {
    
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.github.com"
    }

    func searchRepositories(query: String, completion: @escaping (Result<Data, Error>) -> Void) {

        let timeout = 2.0
        DispatchQueue.global().asyncAfter(deadline: .now() + timeout) {
            DispatchQueue.main.async {

                let data = "data".data(using: .utf8)!
                completion(Swift.Result.success(data))
            }
        }
    }
}
