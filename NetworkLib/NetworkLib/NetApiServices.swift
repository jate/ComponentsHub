//
//  GithubApiService.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import Dispatch

import ProtocolLibrary
import ComponentsHub

class NetApiServices : NetApiProtocol {
    func github() -> Github {
        return GithubImpl()
    }

    func user() -> User {
        return UserImpl()
    }

    func userLogin() -> UserLogin {
        return UserLoginImpl()
    }
}
