//
//  LowestCostAlogirthm.swift
//  PathOfLowestCost
//
//  Created by Suneel on 3/29/17.
//  Copyright © 2017 Suneel. All rights reserved.
//

import Foundation

class LowestCostAlogirthm {
    
    var arrayForPathTraversed : Array<Dictionary<String, Any>> = Array<Dictionary<String, Any>>()
    var arrayForPathTraversedInWholegrid : Array<Dictionary<String, Any>> = Array<Dictionary<String, Any>>()
    var isRowFine:Bool = true
    
    // MARK:-  Function to take input grid and give output for the objective
    
    // Input
    // The main function that prints all paths from top left to bottom right
    // in a grid 'mat' of size mXn
    // m: number of rows
    // n: number of columns
    // minCost: minimum cost of traversing the grid
    
    // Output
    // grid traversed Yes or No
    // Minimum cost
    // path Traversed
    
    
    func findAllPathsForGrid(aGrid: [[Int]], rows: Int, coloumns: Int) {
        
        let pathTraversed  = [Int]()
        let rowsIncludedInPath = [Int]()
        
        if coloumns > 1{
            for i in 0..<rows{
                // as problem statements says that entry point can be any row in grid, need to find minimum path from each row
                //
                self.findAllTraversedPathForGrid(grid: aGrid, startingRow:i, startingColoumn: 0, rows: rows, coloumns: coloumns, paths: pathTraversed, indexForNextRow: 0, rowTraverseds: rowsIncludedInPath, maximumTotalReached: false)
            }
        } else {
            // if grid is having only 1 coloumn instead for using recusive function, 
            // we can find minimum value of row and reduce complexity of traversing whole grid
            //
            let max3 = aGrid.map({ $0.min()!}).min()!
            for (iCurrentIndex, i) in aGrid.enumerated () {
                for _ in i {
                    if i[0] == max3
                    {
                        print (iCurrentIndex)
                        
                        let dict = [Constants.Strings.totalValue:max3, Constants.Strings.path:String(iCurrentIndex+1)] as [String : Any]
                        arrayForPathTraversed.append(dict)
                        break
                    }
                }
            }
        }
        
        // sorting the output array for minimum cost
        let sortedResults: Any = arrayForPathTraversed.sorted { (dict1, dict2) -> Bool in
            let a1 = dict1[Constants.Strings.totalValue] as? Int
            let a2 = dict2[Constants.Strings.totalValue] as? Int
            return a1! < a2!
        }
        
        let sort =  sortedResults as! Array<Dictionary<String,Any>>
        var dict = Dictionary<String, Any>()
        dict = sort[0]
        let number : Int? =  dict[Constants.Strings.totalValue]as? Int
        
        // total value reaches maximum cost i.e 50 need to find path with low cost and stop grid traversing
        //
        if let num = number {
            if num > 50 {
                arrayForPathTraversed.removeAll()
                
                for i in 0..<rows {
                    // as problem statements says that entry point can be any row in grid, need to find minimum path from each row
                    self.findAllTraversedPathForGrid(grid: aGrid, startingRow:i, startingColoumn: 0, rows: rows, coloumns: coloumns, paths: pathTraversed, indexForNextRow: 0, rowTraverseds: rowsIncludedInPath, maximumTotalReached: true)
                }
                if arrayForPathTraversedInWholegrid.count > 0 {
                    // sort based on cost first
                    let sortedCostArray = self.sortArrayBasedOnTotalCost(arrayForCostandPath: arrayForPathTraversedInWholegrid)
                    // sort based on maximum rows traversed
                    let sortedPathArray = self.sortArrayBasedOnPathTrversed(arrayForCostandPath: sortedCostArray)
                    
                    if sortedPathArray.count > 0 {
                        let dictionaryForCostandPath  = sortedPathArray[0]
                        self.setDataForDisplay(resultDictionary: dictionaryForCostandPath, gridColoum: coloumns)
                    }
                }
            } else {
                if arrayForPathTraversed.count > 0 {
                    // sort based on cost
                    let sortedCostArray = self.sortArrayBasedOnTotalCost(arrayForCostandPath: arrayForPathTraversed)
                    let dictionaryForCostandPath = sortedCostArray[0]
                    self.setDataForDisplay(resultDictionary: dictionaryForCostandPath, gridColoum: coloumns)
                }
            }
        }
    }
    
    // MARK:- Sorting array to find minumum cost
    /*
     Input:  MutableArray of cost and path
     */
    func sortArrayBasedOnTotalCost(arrayForCostandPath:Array<Dictionary<String, Any>>) -> Array<Dictionary<String, Any>> {
        let sortedCostArray: Any = arrayForCostandPath.sorted { (dict1, dict2) -> Bool in
            let a1 = dict1[Constants.Strings.totalValue] as? Int
            let a2 = dict2[Constants.Strings.totalValue] as? Int
            return a1! < a2!
        }
        
        return sortedCostArray as! Array<Dictionary<String,Any>>
    }
    
    // MARK:- Sorting array to find maximum path traversed
    /*
     Input: MutableArray of cost and path
     */
    func sortArrayBasedOnPathTrversed(arrayForCostandPath:Array<Dictionary<String, Any>>) -> Array<Dictionary<String, Any>> {
        let sortedPathArray: Any = arrayForCostandPath.sorted { (dict1, dict2) -> Bool in
            let p1  = dict1[Constants.Strings.path] as? String
            let p2  = dict2[Constants.Strings.path] as? String
            // path for maximum row traversed
            //
            return (p1?.characters.count)! > (p2?.characters.count)!
        }
        
        return sortedPathArray as! Array<Dictionary<String,Any>>
    }
    
    // MARK:- Function to show output on UI
    /*
     Input: Dictionary with cost and path
     */
    func setDataForDisplay(resultDictionary: Dictionary<String, Any>, gridColoum:Int)
    {
        let totalValue = resultDictionary[Constants.Strings.totalValue] as? Int
        if let aTotalValue = totalValue {
            DataManager.sharedInstance.arrayForCostAndPath?.insert(String(aTotalValue), at: 0)
        }
        
        let path = resultDictionary[Constants.Strings.path] as? String
        if let aPath = path {
            DataManager.sharedInstance.arrayForCostAndPath?.insert(aPath, at: 1)
        }
        
        let pathString = resultDictionary[Constants.Strings.path] as? String
        if pathString?.characters.count == gridColoum{
            DataManager.sharedInstance.resultforWholeGridTraversing  = Constants.Strings.yes
        } else {
            DataManager.sharedInstance.resultforWholeGridTraversing  = Constants.Strings.no
        }
    }
    
    // MARK:-  Recursive function to take input grid and give output of the path and Cost
    // rows: row travered in grid
    // coloumns: column traversed in grid
    // path: array storing  traversed values
    // indexForNextRow: index of next row
    
    
    func findAllTraversedPathForGrid(grid: [[Int]], startingRow: Int, startingColoumn: Int, rows: Int, coloumns: Int,  paths: [Int], indexForNextRow: Int,  rowTraverseds: [Int], maximumTotalReached:Bool){
        
        var str = String()
        var iRow = startingRow
        let jCol = startingColoumn
        var path = paths
        var rowTraversed = rowTraverseds
        
        // Reached the bottom of the grid so we are left with
        // only option to move right
        //
        if iRow == rows - 1 {
            var total = 0
            //traversing through the row
            for k in jCol..<coloumns {
                path.insert(grid[iRow][k], at: (indexForNextRow + k - jCol))
                // if maximum value for total is not reached
                if maximumTotalReached == false {
                    rowTraversed.insert(iRow + 1, at: (indexForNextRow + k - jCol))
                } else {
                    // if maximum value for total is  reached
                    //
                    for l in 0..<path.count {
                        total = total + path [l]
                    }
                    // total for path is less than 50 then set the data in array
                    //
                    if total < 50 {
                        rowTraversed.insert(iRow + 1, at: (indexForNextRow + k - jCol))
                        for l in 0..<rowTraversed.count {
                            str += "\(rowTraversed [l])"
                        }
                        // adding the path to array if total is less than 50
                        let dict = [Constants.Strings.totalValue:total, Constants.Strings.path:str] as [String : Any]
                        arrayForPathTraversed.append(dict)
                    } else {
                        // if total is greater than 50 saving the last path whose value was less than 50
                        let contains = arrayForPathTraversedInWholegrid.contains(where: { (dict) -> Bool in
                            let dictionaryforCostAndPathTraversed = arrayForPathTraversed[arrayForPathTraversed.count-1]
                            let total1 = dict[Constants.Strings.totalValue] as? Int
                            let path1 = dict[Constants.Strings.path] as? String
                            let total2 = dictionaryforCostAndPathTraversed[Constants.Strings.totalValue] as? Int
                            let path2 = dictionaryforCostAndPathTraversed[Constants.Strings.path] as? String
                            
                            return (total1 == total2) && (path1 == path2)
                            
                        })
                        
                        if contains == false {
                            //adding the path with value less than 50, it can be half traversed path also
                            if (rowTraversed.count > 1)  && (arrayForPathTraversed.count != 0) {
                                if (self.isRowTraversedCorrectly(rowAdded:iRow+1, rowTraversedArray: rowTraversed)) {
                                    arrayForPathTraversedInWholegrid.append(arrayForPathTraversed[arrayForPathTraversed.count-1])
                                }
                            }
                        }
                    }
                }
            }
            
            if maximumTotalReached == false {
                // if maximum value for total is not reached then add the path to array
                //
                var total = 0
                for l in 0..<indexForNextRow + coloumns - jCol {
                    total = total + path [l]
                }
                for l in 0..<indexForNextRow + coloumns - jCol {
                    str += "\(rowTraversed [l])"
                }
                
                let dict = [Constants.Strings.totalValue:total, Constants.Strings.path:str] as [String : Any]
                arrayForPathTraversed.append(dict)
            }
            return
        }
        
        
        // Reached the right corner of the grid we are left with
        // only the downward movement.
        //
        if (jCol == coloumns - 1) && coloumns > 1 {
            var total = 0
            for k in iRow..<rows {
                path.insert(grid [k][jCol], at: (indexForNextRow + k - jCol))
                // if maximum value for total is not reached
                //
                if maximumTotalReached == false {
                    rowTraversed.insert(iRow + 1, at: (indexForNextRow + k - jCol))
                } else {
                    // if maximum value for total is  reached
                    //
                    for l in 0..<path.count {
                        total = total + path [l]
                    }
                    if total < 50 {
                        // total for path is less than 50 then set the data in array
                        rowTraversed.insert(iRow + 1, at: (indexForNextRow + k - jCol))
                        for l in 0..<rowTraversed.count {
                            str += "\(rowTraversed [l])"
                        }
                        // adding the path to array if total is less than 50
                        //
                        let dict = [Constants.Strings.totalValue:total, Constants.Strings.path:str] as [String : Any]
                        arrayForPathTraversed.append(dict)
                    } else {
                        // if total is greater than 50 saving the last path whose value was less than 50
                        let contains = arrayForPathTraversedInWholegrid.contains(where: { (dict) -> Bool in
                            let dictionaryforCostAndPathTraversed = arrayForPathTraversed[arrayForPathTraversed.count-1]
                            let total1 = dict[Constants.Strings.totalValue] as? Int
                            let path1 = dict[Constants.Strings.path] as? String
                            let total2 = dictionaryforCostAndPathTraversed[Constants.Strings.totalValue] as? Int
                            let path2 = dictionaryforCostAndPathTraversed[Constants.Strings.path] as? String
                            
                            return (total1 == total2) && (path1 == path2)
                        })
                        
                        if contains == false {
                            //adding the path with value less than 50, it can be half traversed path also
                            //
                            if (rowTraversed.count > 1)  && (arrayForPathTraversed.count != 0) {
                                if (self.isRowTraversedCorrectly(rowAdded:iRow+1, rowTraversedArray: rowTraversed)) {
                                    arrayForPathTraversedInWholegrid.append(arrayForPathTraversed[arrayForPathTraversed.count-1])
                                    
                                }
                            }
                        }
                    }
                }
            }
            
            if maximumTotalReached == false {
                // if maximum value for total is not reached then add the path to array
                //
                var total = 0
                for l in 0..<indexForNextRow + rows - iRow {
                    total = total + path[l]
                }
                for l in 0..<indexForNextRow + rows - iRow {
                    str += "\(rowTraversed [l])"
                }
                let dict = [Constants.Strings.totalValue:total, Constants.Strings.path:str] as [String : Any]
                arrayForPathTraversed.append(dict)
            }
            return
        }
        // Add the current cell to the path being generated
        //
        path.insert(grid[iRow][jCol], at: indexForNextRow)
        
        if maximumTotalReached == false {
            rowTraversed.insert(iRow + 1, at: indexForNextRow)
        } else {
            // if maximum value for total is  reached
            //
            var total = 0
            for l in 0..<path.count {
                total = total + path [l]
            }
            // total for path is less than 50 then set the data in array
            //
            if total < 50 {
                rowTraversed.insert(iRow + 1, at: indexForNextRow);
                for l in 0..<rowTraversed.count {
                    str += "\(rowTraversed [l])"
                }
                let dict = [Constants.Strings.totalValue:total, Constants.Strings.path:str] as [String : Any]
                arrayForPathTraversed.append(dict)
            } else{
                // if total is greater than 50 saving the last path whose value was less than 50
                //
                let contains = arrayForPathTraversedInWholegrid.contains(where: { (dict) -> Bool in
                    let dictionaryforCostAndPathTraversed = arrayForPathTraversed[arrayForPathTraversed.count-1]
                    let total1 = dict[Constants.Strings.totalValue] as? Int
                    let path1 = dict[Constants.Strings.path] as? String
                    let total2 = dictionaryforCostAndPathTraversed[Constants.Strings.totalValue] as? Int
                    let path2 = dictionaryforCostAndPathTraversed[Constants.Strings.path] as? String
                    
                    return (total1 == total2) && (path1 == path2)
                })
                
                if contains == false {
                    //adding the path with value less than 50, it can be half traversed path also
                    if (rowTraversed.count > 1)  && (arrayForPathTraversed.count != 0) {
                        if (self.isRowTraversedCorrectly(rowAdded:iRow+1, rowTraversedArray: rowTraversed)) {
                            arrayForPathTraversedInWholegrid.append(arrayForPathTraversed[arrayForPathTraversed.count-1])
                        }
                    }
                }
            }
        }
        
        // Recursive call for traversing all paths
        // All the paths that are possible after moving right
        //
        self.findAllTraversedPathForGrid(grid: grid, startingRow: iRow, startingColoumn: jCol + 1, rows:rows, coloumns:coloumns , paths: path, indexForNextRow: indexForNextRow + 1, rowTraverseds: rowTraversed,maximumTotalReached: maximumTotalReached)
        if iRow == rows - 1 {
            iRow = -1
        }
        
        // All the paths that are possible after moving diagonal Down
        //
        self.findAllTraversedPathForGrid(grid: grid, startingRow: iRow + 1, startingColoumn: jCol + 1, rows:rows , coloumns:coloumns, paths: path, indexForNextRow: indexForNextRow + 1, rowTraverseds: rowTraversed,maximumTotalReached: maximumTotalReached)
        if iRow == 0 {
            iRow = rows
        }
        
        // All the paths that are possible after moving diagonally Up
        //
        self.findAllTraversedPathForGrid(grid: grid, startingRow: iRow - 1, startingColoumn: jCol + 1, rows: rows, coloumns:coloumns, paths: path, indexForNextRow: indexForNextRow + 1, rowTraverseds: rowTraversed,maximumTotalReached: maximumTotalReached)
        return
    }
    
    
    // MARK:- Check if Row is traversed correctly
    
    func isRowTraversedCorrectly(rowAdded:Int, rowTraversedArray:[Int])-> (Bool)
    {
        if ((rowAdded-rowTraversedArray[rowTraversedArray.count-2]) == 1) || ((rowAdded-rowTraversedArray[rowTraversedArray.count-2]) == -1) || ((rowAdded-rowTraversedArray[rowTraversedArray.count-2]) == 0) {
            return true
        } else {
            return false
        }
    }
}
