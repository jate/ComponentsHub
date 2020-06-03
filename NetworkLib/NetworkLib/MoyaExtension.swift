//
//  MoyaExtension.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import Moya
import SwiftyJSON

import ProtocolLibrary

// MARK - Cancellable
class CancellableProxy {
    var moyaCancellable : Moya.Cancellable

    init(_ cancellable: Moya.Cancellable) {
        self.moyaCancellable = cancellable
    }
}

extension CancellableProxy : ProtocolLibrary.Cancelable {
    func cancel() {
        moyaCancellable.cancel()
    }
    var isCancelled: Bool {
        moyaCancellable.isCancelled
    }
}

extension Moya.Cancellable {

    /// 用于将Moya的Cancellable协议 转换至 协议库中定义的 Cancellable协议。
    func asCancellable() -> ProtocolLibrary.Cancelable {
        return CancellableProxy(self)
    }
}

// MARK - JSON Parser
extension Response {

    func map<T: SwiftJSONAble>(to type:T.Type) throws -> T {
        let jsonObject = try mapJSON()

        guard let mappedObject = T(json: JSON(jsonObject)) else {
            throw MoyaError.jsonMapping(self)
        }

        return mappedObject
    }

    func map<T: SwiftJSONAble>(to type:[T.Type]) throws -> [T] {
        let jsonObject = try mapJSON()

        let mappedArray = JSON(jsonObject)
        let mappedObjectsArray = mappedArray.arrayValue.compactMap { T(json: $0) }

        return mappedObjectsArray
    }

}

