//
//  ViewModelType.swift
//  UserLogin
//
//  Created by JateXu on 2020/6/4.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
