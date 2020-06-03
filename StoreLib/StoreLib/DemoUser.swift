//
//  DemoUser.swift
//  StoreLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

import RealmSwift
import ProtocolLibrary

class DemoUser : Object {
    @objc dynamic var id = ""
    @objc dynamic var name: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var info: String?

    override static func primaryKey() -> String? {
        return "id"
    }


}

extension DemoUser {
    convenience init(model: DemoUserModel) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.password = model.password
        self.info = model.info
    }

    func toModel() -> DemoUserModel {
        return DemoUserModel.init(name: name, password: password, info: info, id)
    }
}

struct DemoUserLogicImpl {
}

extension DemoUserLogicImpl : DemoUserLogic {

    func saveUser(_ model: DemoUserModel) -> Bool {

        let realm = RealmReposities.userRealm

        // remove this code after test
        //var storedUser = realm.objects(DemoUser.self).filter({ $0.id == model.id }).first
        //if storedUser == nil {
        //    storedUser = DemoUser.init(model: model)
        //} else {
        //    storedUser!.name = model.name
        //    storedUser!.password = model.password
        //    storedUser!.info = model.info
        //}

        let user = DemoUser.init(model: model)
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch let e {
            print("got error: \(e)")
            return false
        }
        return true
    }

    func removeUser(by model: DemoUserModel) -> Bool {
        removeUser(by: model.id)
    }

    func removeUser(by id: String) -> Bool {

        let realm = RealmReposities.userRealm

        if let user = realm.objects(DemoUser.self).filter({ $0.id == id }).first {
            do {
                try realm.write {
                    realm.delete(user)
                }
            } catch let e {
                print("got error: \(e)")
                return false
            }
        }
        return true
    }

    func fetchUsers() -> [DemoUserModel] {

        let realm = RealmReposities.userRealm

        let allUsers = realm.objects(DemoUser.self)

        var models = [DemoUserModel]()
        for user in allUsers {
            models.append(user.toModel())
        }
        return models
    }
}
