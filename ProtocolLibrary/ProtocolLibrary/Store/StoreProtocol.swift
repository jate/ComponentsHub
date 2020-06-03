//
//  StoreProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//

import Foundation

import ComponentsHub

public protocol StoreProtocol {

    // for demo user model operation
    func user() -> DemoUserLogic
}

extension ComponentsHub {
    public var store: StoreProtocol? {
        get {
            get(protocol: StoreProtocol.self)
        }
    }
}
