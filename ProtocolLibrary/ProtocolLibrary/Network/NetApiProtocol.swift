//
//  NetApiProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ComponentsHub

public protocol NetApiProtocol {

    var scheme: String { get }
    var host: String { get }

    func searchRepositories(query: String, completion: @escaping (Result<Data, Error>) -> Void)
}

extension ComponentsHub {
    public var netApi: NetApiProtocol? {
        get {
            get(protocol: NetApiProtocol.self)
        }
    }
}
