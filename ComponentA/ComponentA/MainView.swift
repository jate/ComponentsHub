//
//  MainView.swift
//  ComponentA
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit

import ComponentsHub
import ProtocolLibrary

import RxSwift

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(label)

        layout()

        let github = ComponentsHub.shared.netApi?.github()
        github?.searchReposities(query: "ComponentsHub") { items in
            print("got items: \(items)")
        }

        testRxSwift()
    }

    lazy var label : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.height, height: 50))
        label.text = "ComponentA - MainViewController"
        label.backgroundColor = .blue
        return label
    }()
}

extension MainViewController {
    private func layout() {
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        // label.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        // label.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension MainViewController {
    func testRxSwift() {
        Observable.of(1).subscribe({_ in

            }).dispose()
    }
}
