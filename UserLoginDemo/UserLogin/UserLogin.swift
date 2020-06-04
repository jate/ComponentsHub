//
//  UserLogin.swift
//  UserLoginDemo
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit

import ComponentsHub
import ProtocolLibrary

public struct UserLogin : UserLoginProtocol {

    // TODO: explicitly to dependency with NetApi\Store
    public static func initialComponents() {

        ComponentsHub.shared.register(protocol: UserLoginProtocol.self) { () -> UserLoginProtocol in
            let service = UserLogin()
            return service
        }
    }

    public func getUserLoginViewController(loginDelegate: UserLoginDelegate) -> UIViewController? {

        /// Use By Emebed on main project
        // let path = Bundle.main.path(forResource: "UserLogin", ofType: "framework", inDirectory: "Frameworks")
        // let userLoginFramework = Bundle.init(path: path!)!
        // let storyboard = UIStoryboard.init(name: "UserLogin", bundle: nil)
        // let viewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController")

        /// Just use it like main project...
        let storyboard = UIStoryboard.init(name: "UserLogin", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController")
        if let vc = viewController as? UserLoginViewController {
            vc.viewModel = UserLoginViewModel()
            vc.viewModel.userLogin = ComponentsHub.shared.netApi?.userLogin()
            vc.viewModel.endLoginDelegate = loginDelegate
            return vc
        }
        return nil
    }

}
