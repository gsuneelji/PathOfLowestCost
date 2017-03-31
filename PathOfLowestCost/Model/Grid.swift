//
//  Grid.swift
//  PathOfLowestCost
//
//  Created by Suneel on 3/29/17.
//  Copyright © 2017 Suneel. All rights reserved.
//

import Foundation

struct Grid {
    let rows: Int, columns: Int
    var a2dArray: [[Int]]
    
    
    /// Constructor Matrix with rows and columns provided
    init (rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        a2dArray = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
    }
    
    func isIndexValid(_ row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            assert(isIndexValid(row, column: column), "Index out of range")
            return a2dArray[row][column]
        }
        set {
            assert(isIndexValid(row, column: column), "Index out of range")
            a2dArray[row][column] = newValue
        }
    }
    
    /// Constructor for the grid from the input String
    init?(inputString : String) {
        
        let rows = inputString.components(separatedBy: "\n")
        let numberArray = rows[0].components(separatedBy: ",")
        let numberOfColumns = numberArray.count
        var resultedGrid = Grid(rows: rows.count, columns: numberOfColumns)
        
        for row in 0..<rows.count {
            let digitsArray = rows[row].components(separatedBy: ",")
            
            for digit in 0..<digitsArray.count {
                let value = digitsArray[digit].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if let number = Int(value) {
                    if digit > numberOfColumns - 1 {
                        // Input string is not valid
                        //
                        return nil
                    }
                    resultedGrid[row,digit] = number
                } else {
                    // Input string is not valid
                    //
                    return nil
                }
            }
        }
        
        // Assigning rows, coloumns and 2d array to grid
        //
        self.rows = resultedGrid.rows
        self.columns = resultedGrid.columns
        self.a2dArray = resultedGrid.a2dArray
    }

}
