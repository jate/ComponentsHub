//
//  UserLoginProtocol.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit

import ComponentsHub

public protocol UserLoginDelegate {
    func userLoginSuccess(_ info: String)
    func userLoginFailure()
}

public protocol UserLoginProtocol {

    func getUserLoginViewController(loginDelegate: UserLoginDelegate) -> UIViewController?
}

extension ComponentsHub {
    public var login: UserLoginProtocol? {
        get {
            get(protocol: UserLoginProtocol.self)
        }
    }
}
