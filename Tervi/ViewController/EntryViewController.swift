//
//  EntryViewController.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/25.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

enum ClientError: Error {
    case notValidValue(String)
    case outOfRange(String)
}

class EntryViewController: UIViewController {

    @IBOutlet weak var columnTF: UITextField!
    @IBOutlet weak var rowTF: UITextField!
    
    @IBAction func tapConfirm(_ sender: UIButton) {
        
        do {
            let position = try isValidEnteringValue(maxColumn: 4, maxRow: 4)
            performSegue(withIdentifier: "toNextVC", sender: position)
        } catch let error as ClientError {
            switch error {
            case .notValidValue(let msg), .outOfRange(let msg):
                showToast(message: msg)
            }
            
        } catch {
            print("Unhandled error: \(error)")
        }
    }
        
    func isValidEnteringValue(maxColumn: Int, maxRow: Int) throws -> Position {
        guard let numberOfColumn = Int(columnTF.text ?? "") else {
            throw ClientError.notValidValue("行數不得為空白或非數字的值")
        }
        
        guard let numberOfRow = Int(rowTF.text ?? "") else {
            throw ClientError.notValidValue("列數不得為空白或非數字的值")
        }
        
        
        guard numberOfColumn <= maxColumn && numberOfRow <= maxRow else {
            throw ClientError.notValidValue("行數不得超過 \(maxColumn),列數不得超過 \(maxRow)")
        }
        
        return Position(column: numberOfColumn, row: numberOfRow)
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
