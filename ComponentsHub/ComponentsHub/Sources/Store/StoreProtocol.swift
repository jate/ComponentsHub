//
//  StoreProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//

import Foundation

public protocol StoreProtocol {

    func addOrUpdate(data: Data) -> Bool

    func remove(data: Data) -> Bool


}


extension ComponentsHub {
    public var store: StoreProtocol? {
        get {
            let key = "\(StoreProtocol.self)"
            guard let closure = protocolClosures[key] else {
                return nil
            }
            return closure() as? StoreProtocol
        }
    }
}
