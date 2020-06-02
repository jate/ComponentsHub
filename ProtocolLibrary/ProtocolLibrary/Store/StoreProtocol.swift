//
//  StoreProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//

import Foundation

import ComponentsHub

public protocol StoreProtocol {

    func addOrUpdate(data: Data) -> Bool

    func remove(data: Data) -> Bool


}


extension ComponentsHub {
    public var store: StoreProtocol? {
        get {
            get(protocol: StoreProtocol.self)
        }
    }
}
