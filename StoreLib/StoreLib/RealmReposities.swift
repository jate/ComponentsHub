//
//  RealmReposities.swift
//  StoreLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import RealmSwift

struct RealmReposities {

    static var userRealm: Realm = {
        realm(with: "Users")
    }()

    static func realm(with modual: String) -> Realm {

        var config = Realm.Configuration()

        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(modual).realm")

        return try! Realm.init(configuration: config)
    }
}
