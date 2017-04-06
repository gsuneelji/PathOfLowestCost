//
//  DataManager.swift
//  PathOfLowestCost
//
//  Created by Suneel on 3/29/17.
//  Copyright © 2017 Suneel. All rights reserved.
//

import Foundation

class DataManager {
    //MARK: Shared Instance
    static let sharedInstance = DataManager ()
    
    //MARK:- Local Variable
    var arrayForCostAndPath : [String]? = nil
    var resultforWholeGridTraversing: String? = nil
    
    //MARK:- Init
    convenience init() {
        self.init(array : [])
    }
    
    //MARK:- Init Array
    
    init( array : [String]) {
        arrayForCostAndPath = array
    }
    
    //MARK:- To clear data once the output is recieved
    func clear() {
        arrayForCostAndPath?.removeAll()
        resultforWholeGridTraversing = nil
    }
}
