//
//  UserLoginExtension.swift
//  UserLogin
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import RxSwift

import ProtocolLibrary

extension ProtocolLibrary.UserLogin {

    func login(userName: String, password: String) -> Observable<UserLoginResult> {
        return Observable.create { observer in

            self.login(userName: userName, password: password) {

                observer.on(Event.next($0!))

                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
