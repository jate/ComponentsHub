//
//  UserDataStore.swift
//  StoreLibDemo
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import ProtocolLibrary

class RepositiesStore: StoreProtocol {

    func user() -> DemoUserLogic {
        return DemoUserLogicImpl()
    }

}
