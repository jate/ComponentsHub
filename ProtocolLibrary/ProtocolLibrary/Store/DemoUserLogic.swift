//
//  DemoUserLogic.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

public protocol DemoUserLogic {
    func saveUser(_ model: DemoUserModel) -> Bool

    func removeUser(by id: String) -> Bool
    func removeUser(by model: DemoUserModel) -> Bool

    func fetchUsers() -> [DemoUserModel]
}
