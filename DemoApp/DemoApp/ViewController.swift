//
//  ViewController.swift
//  DemoApp
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import UIKit
import ComponentsHub
import ProtocolLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        testStoreLib()
        testStoreUsers()

        testNetLib()


    }

    @IBAction func buttonClicked() {
        guard let vc = ComponentsHub.shared.comA?.getComponentAMainViewController(title: "Test") else {
            return
        }

        let nav = UINavigationController.init(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }

    func testStoreLib() {
        // Directly dependency
        // let lib = StoreLib()

        // Use Components Hub
        //let data = "d".data(using: .utf8)!
        //let _ = ComponentsHub.shared.store?.addOrUpdate(data: data)

        //let _ = ComponentsHub.shared.store?.remove(data: data)
    }

    func testNetLib() {

        // Use Components Hub
        let _ = ComponentsHub.shared.netApi?.searchRepositories(query: "", completion: { result in

            switch(result) {
            case .success(let data):
                print("received data: \(data)")
            case .failure(let e):
                print("got error: \(e)")
            }

        })
    }

    func testStoreUsers() {
        let userLogic = ComponentsHub.shared.store?.user()

        let user = DemoUserModel.init(name: "jate", password: "##$W@$@SFASDF")
        userLogic!.saveUser(user)

        for user in userLogic!.fetchUsers() {
            print("user id: \(user.id), name: \(user.name)")

            userLogic!.removeUser(by: user)
        }
    }
}

