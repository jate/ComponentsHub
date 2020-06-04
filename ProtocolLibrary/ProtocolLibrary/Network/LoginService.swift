//
//  LoginService.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

public enum UserLoginResult {
    case success(info: String)
    case failure
}

public protocol UserLogin {
    @discardableResult
    func login(userName: String, password: String, completion: @escaping (UserLoginResult?) -> Void) -> Cancelable
}
