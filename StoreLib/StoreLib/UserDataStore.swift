//
//  UserDataStore.swift
//  StoreLibDemo
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ComponentsHub
import ProtocolLibrary

class UserDataStore: StoreProtocol {

    func addOrUpdate(data: Data) -> Bool {
        print("StoreLib add or update \(data)")
        return true
    }

    func remove(data: Data) -> Bool {
        print("StoreLib remove")
        return true
    }


}
