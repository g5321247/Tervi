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
        stackView.addBackground(color: UIColor(red: 28/255, green: 211/255, blue: 213/255, alpha: 1))
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
    }

}
