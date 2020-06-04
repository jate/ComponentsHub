//
//  UserLoginView.swift
//  UserLogin
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class UserLoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var userPasswordTextFiled: UITextField!
    @IBOutlet private(set) weak var inputCenterConstraint: NSLayoutConstraint!
    private var inputCenterValue: CGFloat!

    var viewModel: UserLoginViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()

        self.controlKeyboardInputFlow()
        self.controlKeyboardHidden()

        inputCenterValue = inputCenterConstraint.constant
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func bindViewModel() {
        let input = UserLoginViewModel.Input(
            username: userNameTextFiled.rx.text.orEmpty.asDriver(),
            password: userPasswordTextFiled.rx.text.orEmpty.asDriver(),
            loginTaps: loginBtn.rx.tap.asSignal()
        )

        let output = viewModel.transform(input: input)

        output.loginBtnEnabled
            .drive(loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)

        output.loginBtnEnabled
            .drive(onNext: { [weak self] enabled in
                guard let strongSelf = self else { return }
                strongSelf.loginBtn.backgroundColor = enabled ? .systemTeal : .lightGray
            })
            .disposed(by: disposeBag)

        output.result
            .drive(onNext: { [weak self] result in
                guard let strongSelf = self else { return }

                let alert = UIAlertController(title: "Congrs", message: "Login Successfully.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in

                    let delegate = strongSelf.viewModel.endLoginDelegate
                    switch result {
                    case .success(let info):
                        delegate?.userLoginSuccess(info)
                    case .failure:
                        delegate?.userLoginFailure()
                    }
                    strongSelf.dismiss(animated: true, completion: nil)
                })
                strongSelf.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        output.keyboard
            .drive(onNext: { [weak self] in
                guard let keyboardInfo = $0,
                    let strongSelf = self else { return }

                strongSelf.view.layoutIfNeeded()
                strongSelf.inputCenterConstraint.constant = strongSelf.inputCenterValue - keyboardInfo.frame.size.height / 2
                UIView.animate(withDuration: keyboardInfo.animationDuration,
                               delay: 0,
                               options: keyboardInfo.animationCurve,
                               animations: { strongSelf.view.layoutIfNeeded() },
                               completion: nil)

            }).disposed(by: disposeBag)

        output.loading.subscribe { [weak self] event in
            guard let strongSelf = self else { return }
            _ = event.map {
                if $0 {
                    strongSelf.startAnimating(CGSize(width: 50, height: 50), type: .ballRotateChase, color: .systemTeal)
                } else {
                    strongSelf.stopAnimating()
                }
            }
        }.disposed(by: disposeBag)
    }

    func controlKeyboardInputFlow() {
        userNameTextFiled.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.userPasswordTextFiled.becomeFirstResponder()
        }.disposed(by: disposeBag)

        userPasswordTextFiled.rx.controlEvent(.editingDidEnd)
        .asObservable()
            .subscribe { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.userPasswordTextFiled.resignFirstResponder()
        }.disposed(by: disposeBag)
    }

    func controlKeyboardHidden() {
        self.loginBtn.rx.tap.asSignal().asObservable().subscribe { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.userNameTextFiled.resignFirstResponder()
            strongSelf.userPasswordTextFiled.resignFirstResponder()
        }.disposed(by: disposeBag)
    }
}

extension UserLoginViewController : NVActivityIndicatorViewable {
}
