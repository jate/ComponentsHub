//
//  StoreLib.swift
//  StoreLibDemo
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import ComponentsHub

public class StoreLib {

    public static func initialComponents() {

        ComponentsHub.shared.register(protocol: StoreProtocol.self) { () -> StoreProtocol in
            let dataStore = UserDataStore()
            return dataStore
        }
    }
}
