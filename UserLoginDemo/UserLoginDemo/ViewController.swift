//
//  ViewController.swift
//  UserLoginDemo
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import UIKit

import ComponentsHub
import ProtocolLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("just for running?")


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let loginModual = ComponentsHub.shared.login!
        let loginVC = loginModual.getUserLoginViewController(loginDelegate: self)

        present(loginVC!, animated: true, completion: nil)
    }
}

extension ViewController : UserLoginDelegate {
    func userLoginSuccess(_ info: String) {
        print("success: \(info)")
    }

    func userLoginFailure() {
        print("failure...")
    }
}
