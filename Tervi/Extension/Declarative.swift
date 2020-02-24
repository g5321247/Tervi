//
//  Declaritive.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/24.
//  Copyright © 2020 11111. All rights reserved.
//

import Foundation

protocol Declarative: AnyObject {
    init()
}

extension Declarative {
    init(configureHandler: (Self) -> Void) {
        self.init()
        configureHandler(self)
    }
}

extension NSObject: Declarative {}
