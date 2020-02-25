//
//  EntryViewController.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/25.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var columnTF: UITextField!
    @IBOutlet weak var rowTF: UITextField!
    
    @IBAction func tapConfirm(_ sender: UIButton) {
        guard let numberOfColumn = Int(columnTF.text ?? "") else {
            showToast(message: "行數")
            return
        }
        
        guard let numberOfRow = Int(rowTF.text ?? "") else {
            showToast(message: "列數")
            return
        }
        
        performSegue(withIdentifier: "toNextVC", sender: Position(column: numberOfColumn, row: numberOfRow))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextVC" {

            let vc = segue.destination as? ViewController
            let position = sender as! Position
            vc?.inject(numberOfColumn: position.column, numberOfRow: position.row)
        }
    }
    
    private func showToast(message: String) {
        let alertVC = UIAlertController(title: "錯誤", message: "\(message) 不得為空白或非數字的值", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
