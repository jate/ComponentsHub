//
//  UserService.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

public protocol User {
    @discardableResult
    func getUserInfo(name: String, completion: @escaping (DemoUserModel?) -> Void) -> Cancelable
}

