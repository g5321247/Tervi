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
    var updateLabel: ((_ current: Position?, _ new: Position) -> Void)? { get set }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }

    var updateLabel: ((_ current: Position?, _ new: Position) -> Void)?

    private var timer: Timer?
    private var previousPosition: Position?
    private var newPosition: Position {
        get {
            let newPosition = Position(column: 1, row: 1)
            previousPosition = newPosition
            return newPosition
        }
    }
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.updateLabel?(self.previousPosition, self.newPosition)
        })
    }
    
    func startTimer() {
        timer?.fire()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    var columns = 3
    var rows = 2
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for sub
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        renderUI()
        let sub = stackView.arrangedSubviews[2] as! BoarderStackView
        let view = sub.arrangedSubviews[2] as! CellView
        
        sub.addBoarder(color: .focus)
        
        bindViewModel()
        viewModel.inputs.startTimer()
    }
    
    private func renderUI() {
        for column in 0 ... columns {
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
        
        outputs.updateLabel = { [weak self] (current, new) in
            if let current = current {
                let sub = self?.stackView.arrangedSubviews[current.column] as! BoarderStackView
                 let view = sub.arrangedSubviews[current.row] as! CellView
                view.textLL.isHidden = true
            }
            
            let sub = self?.stackView.arrangedSubviews[new.column] as! BoarderStackView
            let view = sub.arrangedSubviews[new.row] as! CellView
            view.textLL.isHidden = false
        }
    }
}
