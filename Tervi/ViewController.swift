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
    var columns = 3
    var rows = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for sub
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        for column in 0 ... columns {
            let subStackView = BoarderStackView {
                $0.axis = .vertical
                $0.distribution = .fillEqually
            }
            for _ in 0 ... rows {
                let baseView = CellView {
                    switch column % 4 {
                    case 0:
                        $0.setColor(color: .blue)
                    case 1:
                        $0.setColor(color: .red)
                    case 2:
                        $0.setColor(color: .yellow)
                    case 3:
                        $0.setColor(color: .brown)
                    default:
                        fatalError()
                    }
                }
                subStackView.addArrangedSubview(baseView)
            }
            
            let buttonView = ButtonView {
                $0.confirmBtn.addTarget(self, action: #selector(tapConfirmBtn(_:)), for: .touchUpInside)
            }
            subStackView.addArrangedSubview(buttonView)
            stackView.addArrangedSubview(subStackView)
        }
        
        let sub = stackView.arrangedSubviews[2] as! BoarderStackView
        sub.addBoarder(color: .focus)
    }
    
    @objc func tapConfirmBtn(_ sender: UIButton) {
        // clear vm
    }
}
