//
//  ComponentAProtocol.swift
//  ComponentsHub
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit

public protocol ComponentAProtocol {
    func getComponentAMainViewController(title: String) -> UIViewController
}


extension ComponentsHub {
    public var comA: ComponentAProtocol? {
        get {
            get(protocol: ComponentAProtocol.self)
        }
    }
}
