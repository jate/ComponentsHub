//
//  DemoUserModel.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

public struct DemoUserModel {
    public private(set) var id = ""
    public var name: String
    public var password: String
    public var info: String?

    public init(name: String, password: String, info: String? = "",_ id: String = "") {
        self.name = name
        self.password = password
        self.info = info
        if id.count == 0 {
            self.id = UUID.init().uuidString
        } else {
            self.id = id
        }
    }
}
