//
//  LowestCostViewController.swift
//  PathOfLowestCost
//
//  Created by Suneel on 3/29/17.
//  Copyright © 2017 Suneel. All rights reserved.
//

import UIKit

class LowestCostViewController: UIViewController {
    
    @IBOutlet var minimumCostLabel: UILabel!
    @IBOutlet var rowTraversedInMatrixLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet weak var matrixTextView: UITextView!
    var traversedPathArray:NSMutableArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        traversedPathArray = NSMutableArray()
    }
    
    /// Button action when submit button pressed
    @IBAction func calculateMinimumCostButtonPressed() {
        matrixTextView.resignFirstResponder()
        vadidateInputAndCalculateCost()
    }
    
    /// Validate input matrix
    func vadidateInputAndCalculateCost() {
        let inputMatrix = matrixTextView.text
        
        if inputMatrix?.characters.count ?? 0 > 0 {
            let lowestCostAlogirthm = LowestCostAlogirthm()
            let resultGrid = Grid.init(inputString : inputMatrix ?? "")
            if resultGrid != nil {
                let row = resultGrid?.a2dArray.count
                let coloumn = resultGrid?.a2dArray[0].count
                lowestCostAlogirthm.findAllPathsForGrid(aGrid: (resultGrid?.a2dArray)!, rows: row!, coloumns: coloumn!)
                
                if let arrayForCostAndPath = DataManager.sharedInstance.arrayForCostAndPath,  arrayForCostAndPath.count > 1 {
                    minimumCostLabel.text = DataManager.sharedInstance.arrayForCostAndPath?[0]
                    rowTraversedInMatrixLabel.text = DataManager.sharedInstance.arrayForCostAndPath?[1]
                } else{
                    minimumCostLabel.text = "0"
                    rowTraversedInMatrixLabel.text = "[]"
                }
                
                if let isMatrixTraversed = DataManager.sharedInstance.resultforWholeGridTraversing, isMatrixTraversed.lowercased() == "yes" {
                    resultLabel.text = isMatrixTraversed
                } else {
                    resultLabel.text = "No"
                }
                
                DataManager.sharedInstance.clear()
            } else {
                let alert = UIAlertController(title: Constants.Errors.invalidInput, message:Constants.Errors.errorText,preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: Constants.Strings.ok, style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: Constants.Errors.invalidInput, message: Constants.Errors.emptyInputError, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: Constants.Strings.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
