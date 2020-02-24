//
//  ViewController.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/19.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for sub
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        for _ in 0 ... 2 {
            let baseView = CellView {
                $0.setColor(color: .blue)
            }
            
            let baseViewTwo = CellView {
                $0.setColor(color: .blue)
            }

            
            let buttonView = ButtonView {
                $0.confirmBtn.addTarget(self, action: #selector(tapConfirmBtn(_:)), for: .touchUpInside)
            }
            
            let subStackView = BoarderStackView(arrangedSubviews: [
                baseView,
                baseViewTwo,
                buttonView
            ])
            
            
            subStackView.axis = .vertical
            subStackView.distribution = .fillEqually
            stackView.addArrangedSubview(subStackView)
        }
        
        let sub = stackView.arrangedSubviews[2] as! BoarderStackView
        sub.addBoarder(color: .brown)
    }
    
    @objc func tapConfirmBtn(_ sender: UIButton) {
        // clear vm
    }
}
