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
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderUI()
        bindViewModel()
        viewModel.inputs.startTimer()
    }
    
    func inject(numberOfColumn: Int, numberOfRow: Int) {
        viewModel = ViewModel(numberOfColumns: numberOfColumn, numberOfRows: numberOfRow)
    }
    
    private func renderUI() {
        for column in 0 ..< viewModel.numberOfColumns {
            stackView.addArrangedSubview(createColumnView(column: column))
        }
    }
    
    private func createColumnView(column: Int) -> BoarderStackView {
        let subStackView = BoarderStackView {
            $0.axis = .vertical
            $0.distribution = .fillEqually
        }
        
        let isFinishedAddingCell = isFinishedAddCellViews(into: subStackView, column: column)
        addBottomView(into: subStackView, isFinishedAddingCell: isFinishedAddingCell, column: column)
        
        return subStackView
    }
    
    private func isFinishedAddCellViews(into stackview: BoarderStackView, column: Int) -> Bool {
        for _ in 0 ..< viewModel.numberOfRows {
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
            stackview.addArrangedSubview(baseView)
        }
        return true
    }
    
    private func addBottomView(into stackview: BoarderStackView, isFinishedAddingCell: Bool, column: Int) {
        guard isFinishedAddingCell else { return }
        let buttonView = ButtonView {
            $0.confirmBtn.addTarget(self, action: #selector(tapConfirmBtn(_:)), for: .touchUpInside)
            $0.confirmBtn.tag = column
        }
        stackview.addArrangedSubview(buttonView)
    }
    
    @objc func tapConfirmBtn(_ sender: UIButton) {
        viewModel.inputs.selectColumn(column: sender.tag)
    }
    
    private func bindViewModel() {
        var outputs = viewModel.outputs
        
        outputs.updateView = { [weak self] (current, new) in
            if let current = current {
                self?.updateCell(at: current, isHidden: true)
            }
            if let new = new {
                self?.updateCell(at: new, isHidden: false)
            }
        }
    }
    
    private func updateCell(at position: Position, isHidden: Bool) {
        let sub = stackView.arrangedSubviews[position.column] as? BoarderStackView
        let view = sub?.arrangedSubviews[position.row] as? CellView
        isHidden ? sub?.removeBorder() : sub?.addBoarder(color: .focus)
        view?.textLL.isHidden = isHidden
    }
}
