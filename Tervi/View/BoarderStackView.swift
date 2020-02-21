//
//  BoarderStackView.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/21.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

class BoarderStackView: UIStackView {
    
    private var lineBorder: CAShapeLayer?
    
    func addBoarder(color: UIColor) {
        guard lineBorder == nil else { return }
        
        let lineView = UIView(frame:
            CGRect(x: frame.origin.x + 5,
                   y: frame.origin.y + 5,
                   width: frame.width - 50,
                   height: frame.height - 50
            )
        )
        
        lineBorder = createBorder(with: lineView)
        lineBorder?.strokeColor = color.cgColor
        lineView.layer.addSublayer(lineBorder!)

        addSubview(lineView)
    }
    
    private func createBorder(with superview: UIView) -> CAShapeLayer {
        let lineBorder = CAShapeLayer()
        lineBorder.frame = superview.bounds
        lineBorder.fillColor = nil
        lineBorder.path = UIBezierPath(roundedRect: superview.bounds, cornerRadius: CGFloat(signOf: 5, magnitudeOf: 5)).cgPath
        lineBorder.lineWidth = 2.5
        
        return lineBorder
    }
    
    func removeBorder() {
        lineBorder?.removeFromSuperlayer()
    }
}
