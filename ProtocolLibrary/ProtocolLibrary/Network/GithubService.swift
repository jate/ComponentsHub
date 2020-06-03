//
//  GithubService.swift
//  ProtocolLibrary
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation

public protocol Github {
    @discardableResult
    func searchReposities(query: String, completion: @escaping ([GithubReposityItem]) -> Void) -> Cancelable

}
