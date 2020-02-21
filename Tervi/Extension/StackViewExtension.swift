//
//  StackViewExtension.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/21.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
