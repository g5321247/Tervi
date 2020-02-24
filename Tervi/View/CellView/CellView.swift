//
//  CellView.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/21.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var alphaColorView: UIView!
    @IBOutlet weak var textLL: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: CellView.self), owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setColor(color: UIColor) {
        bottomView.backgroundColor = color
        let alphaColor = (color.copy() as? UIColor)?.withAlphaComponent(0.5)
        alphaColorView.backgroundColor = alphaColor
    }
}

