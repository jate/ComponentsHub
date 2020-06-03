//
//  NetworkLib.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ComponentsHub
import ProtocolLibrary

public struct NetworkLib {

    public static func initialComponents() {

        ComponentsHub.shared.register(protocol: NetApiProtocol.self) { () -> NetApiProtocol in
            let apiService = NetApiServices()
            return apiService
        }

        /*
        ComponentsHub.shared.register(protocol: Github.self, singleton: true) { () -> Github in
            return GithubImpl()
        }

        ComponentsHub.shared.register(protocol: User.self, singleton: true) { () -> User in
            return UserImpl()
        }
         */
    }

}
