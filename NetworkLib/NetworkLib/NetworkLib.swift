//
//  NetworkLib.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import ComponentsHub

public struct NetworkLib {

    public static func initialComponents() {

        ComponentsHub.shared.register(protocol: NetApiProtocol.self) { () -> NetApiProtocol in
            let apiService = GithubApiService()
            return apiService
        }
    }

}
