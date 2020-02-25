//
//  ViewModel.swift
//  Tervi
//
//  Created by 劉峻岫 on 2020/2/25.
//  Copyright © 2020 11111. All rights reserved.
//

import Foundation

protocol ViewModelInputs {
    func startTimer()
    func selectColumn(column: Int)
}

protocol ViewModelOutputs {
    var updateView: ((_ current: Position?, _ new: Position?) -> Void)? { get set }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }

    var updateView: ((_ current: Position?, _ new: Position?) -> Void)?

    let numberOfColumns: Int
    let numberOfRows: Int
    private var timer: Timer?
    private var currentPosition: Position?
    private var newPosition: Position? {
        get {
            let randomColumn = Int.random(in: 0 ..< numberOfColumns)
            let randomRow = Int.random(in: 0 ..< numberOfRows)

            let newPosition = Position(column: randomColumn, row: randomRow)
            currentPosition = newPosition
            return newPosition
        }
    }
    
    init(numberOfColumns: Int, numberOfRows: Int) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.updateView?(self.currentPosition, self.newPosition)
        })

        timer?.fire()
    }
    
    func selectColumn(column: Int) {
        guard column == currentPosition?.column else { return }
        updateView?(currentPosition, nil)
    }
}
