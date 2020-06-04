//
//  DemoUserInfoItem.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import SwiftyJSON
import ProtocolLibrary

extension DemoUserModel: SwiftJSONAble {
    init?(json: JSON) {
        guard !json.isEmpty else {
            return nil
        }
        guard let name = json["name"].string,
            let id = json["id"].string,
            let password = json["password"].string,
            let info = json["info"].string else {
                return nil
        }
        self.init(name: name, password: password, info: info, id)
    }
}
