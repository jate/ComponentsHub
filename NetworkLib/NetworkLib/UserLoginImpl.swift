//
//  UserLoginImpl.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import Dispatch

import ProtocolLibrary


class UserLoginImpl : UserLogin {
    func login(userName: String, password: String, completion: @escaping (UserLoginResult?) -> Void) -> Cancelable {

        class CancellableTempProxy : ProtocolLibrary.Cancelable {
            func cancel() { }
            var isCancelled: Bool = false
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {

            DispatchQueue.main.async {
                completion(.success(info: "User Login Success."))
            }
        }
        return CancellableTempProxy()
    }
}
