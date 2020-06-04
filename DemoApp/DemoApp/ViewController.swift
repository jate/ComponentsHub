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

    @IBOutlet private(set) weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func testStoreLib() {
        // Directly dependency
        // let lib = StoreLib()

        // Use Components Hub
        //let data = "d".data(using: .utf8)!
        //let _ = ComponentsHub.shared.store?.addOrUpdate(data: data)

        //let _ = ComponentsHub.shared.store?.remove(data: data)
    }
}

extension ViewController {
    @IBAction func componentAButtonClicked() {
        guard let vc = ComponentsHub.shared.comA?.getComponentAMainViewController(title: "Test") else {
            return
        }

        let nav = UINavigationController.init(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
}

extension ViewController : UserLoginDelegate {

    @IBAction func loginButtonClicked() {
        guard let vc = ComponentsHub.shared.login?.getUserLoginViewController(loginDelegate: self) else {
            return
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }

    func userLoginSuccess(_ info: String) {

        let userLogic = ComponentsHub.shared.store?.user()

        _ = userLogic?.fetchUsers().map {
            userLogic?.removeUser(by: $0)
        }
        _ = userLogic?.saveUser(DemoUserModel.init(name: "jate", password: "##$W@$@SFASDF", info: info))

        loginBtn.setTitle("User Has Logined!", for: .normal)
    }

    func userLoginFailure() {

    }
}
