//
//  UserLoginViewModel.swift
//  UserLogin
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

import ComponentsHub
import ProtocolLibrary

final class UserLoginViewModel : ViewModelType {
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let loginTaps: Signal<Void>
    }

    struct Output {
        let loginBtnEnabled: Driver<Bool>
        let result: Driver<UserLoginResult>
        let keyboard: Driver<UIKeyboardInfo?>
        let loading: PublishSubject<Bool>
    }

    var userLogin : ProtocolLibrary.UserLogin!
    var endLoginDelegate: UserLoginDelegate!

    func transform(input: UserLoginViewModel.Input) -> UserLoginViewModel.Output {
        let isUsernameValid = input.username
            .map { $0.count > 0 }
        let isPasswordValid = input.password
            .map { $0.count >= 6 }
        let enabled = Driver.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }

        let loading = PublishSubject<Bool>()

        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { ($0, $1 )}
            .asObservable()
        let result = input.loginTaps
            .asObservable()
            .withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair -> Observable<UserLoginResult> in
                let (username, password) = pair
                return self.userLogin.login(userName: username, password: password)
                .do(onCompleted: {
                    loading.onNext(false)
                }, onSubscribed: {
                    loading.onNext(true)
                })
            }
        .asDriver(onErrorJustReturn: .failure)

        let kbWillHidden = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { UIKeyboardInfo(info: $0.userInfo!)
        }
        let kbWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { UIKeyboardInfo(info: $0.userInfo!)
        }
        let kbSignal = Observable.merge([kbWillShow, kbWillHidden])
            .debug()
            .asDriver(onErrorJustReturn: nil)

        return Output(loginBtnEnabled: enabled,result: result, keyboard: kbSignal, loading: loading)
    }
}
