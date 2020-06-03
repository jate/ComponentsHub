//
//  NetApiProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ComponentsHub

public protocol Cancelable {
    var isCancelled: Bool { get }
    func cancel()
}

public protocol Printable {
    func print()
}

public protocol NetApiProtocol {

    func github() -> Github

    func user() -> User
}

extension ComponentsHub {
    public var netApi: NetApiProtocol? {
        get {
            get(protocol: NetApiProtocol.self)
        }
    }
}
