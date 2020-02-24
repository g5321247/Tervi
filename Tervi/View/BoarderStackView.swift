//
//  BoarderStackView.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/21.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

class BoarderStackView: UIStackView {
    
    private var lineView: UIView?
    
    func addBoarder(color: UIColor) {
        guard lineView == nil else { return }
        let lineView = UIView()
        addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -0.5).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.5).isActive = true
        lineView.isUserInteractionEnabled = false
        
        lineView.layer.borderColor = color.cgColor
        lineView.layer.borderWidth = 2.5
        lineView.layer.cornerRadius = 2.5
    }
    
    
    func removeBorder() {
        lineView?.removeFromSuperview()
    }
}
