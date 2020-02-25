//
//  ButtonView.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/24.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

class ButtonView: UIView {
        
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var confirmBtn: UIButton! {
        didSet {
            confirmBtn.configure {
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.lightGray.cgColor
                $0.titleLabel?.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ButtonView.self), owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

}
