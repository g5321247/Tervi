//
//  ViewController.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/19.
//  Copyright © 2020 11111. All rights reserved.
//

import UIKit

struct Position {
    let column: Int
    let row: Int
}

protocol ViewModelInputs {
    func startTimer()
}

protocol ViewModelOutputs {
    var updateView: ((_ current: Position?, _ new: Position) -> Void)? { get set }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }

    var updateView: ((_ current: Position?, _ new: Position) -> Void)?

    let numberOfColumns: Int
    let numberOfRows: Int
    private var timer: Timer?
    private var previousPosition: Position?
    private var newPosition: Position {
        get {
            let randomColumn = Int.random(in: 0 ..< numberOfColumns)
            let randomRow = Int.random(in: 0 ..< numberOfRows)

            let newPosition = Position(column: randomColumn, row: randomRow)
            previousPosition = newPosition
            return newPosition
        }
    }
    
    init(numberOfColumns: Int, numberOfRows: Int) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.updateView?(self.previousPosition, self.newPosition)
        })
    }
    
    func startTimer() {
        timer?.fire()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    let viewModel = ViewModel(numberOfColumns: 3, numberOfRows: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for sub
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        renderUI()
        let sub = stackView.arrangedSubviews[2] as! BoarderStackView
        
        sub.addBoarder(color: .focus)
        
        bindViewModel()
        viewModel.inputs.startTimer()
    }
    
    private func renderUI() {
        for column in 1 ... viewModel.numberOfColumns {
            stackView.addArrangedSubview(createColumnView(column: column))
        }
    }
    
    private func createColumnView(column: Int) -> BoarderStackView {
        let subStackView = BoarderStackView {
            $0.axis = .vertical
            $0.distribution = .fillEqually
        }
        
        let isFinishedAddingCell = isFinishedAddCellViews(into: subStackView, column: column)
        addBottomView(into: subStackView, isFinishedAddingCell: isFinishedAddingCell)
        
        return subStackView
    }
    
    private func isFinishedAddCellViews(into stackview: BoarderStackView, column: Int) -> Bool {
        for _ in 1 ... viewModel.numberOfRows {
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
    
    private func addBottomView(into stackview: BoarderStackView, isFinishedAddingCell: Bool) {
        guard isFinishedAddingCell else { return }
        let buttonView = ButtonView {
            $0.confirmBtn.addTarget(self, action: #selector(tapConfirmBtn(_:)), for: .touchUpInside)
        }
        stackview.addArrangedSubview(buttonView)
    }
    
    @objc func tapConfirmBtn(_ sender: UIButton) {
        // clear vm
    }
    
    private func bindViewModel() {
        var outputs = viewModel.outputs
        
        outputs.updateView = { [weak self] (current, new) in
            if let current = current {
                self?.updateCell(at: current, isHidden: true)
            }
            self?.updateCell(at: new, isHidden: false)
        }
    }
    
    private func updateCell(at position: Position, isHidden: Bool) {
        let sub = stackView.arrangedSubviews[position.column] as? BoarderStackView
        let view = sub?.arrangedSubviews[position.row] as? CellView
        isHidden ? sub?.removeBorder() : sub?.addBoarder(color: .focus)
        view?.textLL.isHidden = isHidden
    }
}
