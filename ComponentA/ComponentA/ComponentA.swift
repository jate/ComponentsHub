//
//  ComponentA.swift
//  ComponentA
//
//  Created by JateXu on 2020/6/2.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import UIKit

import ComponentsHub

public struct ComponentA : ComponentAProtocol {

    // TODO: explicitly to dependency with NetApi\Store
    public static func initialComponents() {

        ComponentsHub.shared.register(protocol: ComponentAProtocol.self) { () -> ComponentAProtocol in
            let service = ComponentA()
            return service
        }
    }

    public func getComponentAMainViewController(title: String) -> UIViewController {

        let vc = MainViewController.init()
        vc.title = title
        return vc
    }
    
}
