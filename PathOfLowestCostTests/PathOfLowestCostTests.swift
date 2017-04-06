//
//  PathOfLowestCostTests.swift
//  PathOfLowestCost
//
//  Created by Suneel on 3/29/17.
//  Copyright © 2017 Suneel. All rights reserved.
//

import XCTest
@testable import PathOfLowestCost

class PathOfLowestCostTests: XCTestCase {
    var arrayTraversedWithPath:NSMutableArray  = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.sharedInstance.clear()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:-   Test for  Grid of 5x6 Linear Grid - No wraps
    
    func testFindPathForMinimumcostForExample1() {
        let aGrid = [[3, 4, 1, 2, 8, 6], [6, 1, 8, 2, 7, 4], [5, 9, 3, 9, 9, 5], [8, 4, 1, 3, 2, 6], [3, 7, 2, 8, 6, 4]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 5, coloumns: 6)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("16", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("123445", DataManager.sharedInstance.arrayForCostAndPath?[1])
        
    }
    
    //MARK:-   Test for  Grid of 3x4 Linear Grid
    
    func testFindPathForMinimumcostForExample3() {
        let aGrid = [[19,10,19,10,19], [21,23,20,19,12], [20,12,20,11,10]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows:3, coloumns: 5)
        XCTAssertEqual("No", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("48", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("111", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
    
    //MARK:-   Test for  Grid of 5x6 - linear Grid
    
    func testFindPathForMinimumcostForExample2() {
        let aGrid = [[3, 4, 1, 2, 8, 6], [6, 1, 8, 2, 7, 4], [5, 9, 3, 9, 9, 5], [8, 4, 1, 3, 2, 6], [3, 7, 2, 1, 2, 3]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 5, coloumns: 6)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("11", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("121555", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
    
    //MARK:-   Test for  Grid of 1x5
    
    func testFindPathForMinimumcostForExamplewith1row() {
        let aGrid = [[5, 8, 5, 3, 5]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 1, coloumns: 5)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("26", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("11111", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
    
    //MARK:-   Test for  Grid of 5x1
    
    func testFindPathForMinimumcostForExamplewith1Coloumn() {
        let aGrid = [[5],[8],[5],[3],[5]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 5, coloumns: 1)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("3", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("4", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
    
    
    //MARK:-   Test for  Grid of 3x3 - Invalid
    
    func testFindPathForMinimumcostForExample3x3Grid() {
        let aGrid = "5,4,H,\n8,M,7\n5,7,5"
        let grid = Grid(inputString:aGrid)
        XCTAssertNil(grid)
    }
    
    //MARK:-  Test for wrong Grid i.e it is empty
    
    func testFindPathForMinimumcostForValidatingEmptyGridSring() {
        let aGrid = ""
        let grid = Grid(inputString:aGrid)
        XCTAssertNil(grid)
    }
    
    //MARK:-  Test for 3 x 4 Grid - Random Grid
    
    func testFindPathForMinimumcostForRandomGrid() {
        let aGrid = [[60, 3, 3, 6], [6, 3, 7, 9], [5, 6, 8, 3]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 3, coloumns: 4)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("15", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("2213", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
    
    //MARK:-  Test for 3 x 5 Grid - Random Grid
    
    func testFindPathForMinimumcostForExample3x5Grid() {
        let aGrid = [[69, 10, 19, 10, 19], [51, 23, 20, 19, 12], [60, 12, 20, 11, 10]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 3, coloumns: 5)
        XCTAssertNil(DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertNil(DataManager.sharedInstance.arrayForCostAndPath?.first)
    }
    
    //MARK:-  Test for 3 x 4 Grid - Grid With Negative Values
    
    func testFindPathForMinimumcostForGridWithNegatives() {
        let aGrid = [[60, 3, 3, 6], [6, -3, 7, 9], [5, 6, -8, 3]]
        let costAlgo = LowestCostAlogirthm()
        costAlgo.findAllPathsForGrid(aGrid: aGrid, rows: 3, coloumns: 4)
        XCTAssertEqual("Yes", DataManager.sharedInstance.resultforWholeGridTraversing)
        XCTAssertEqual("-2", DataManager.sharedInstance.arrayForCostAndPath?[0])
        XCTAssertEqual("2233", DataManager.sharedInstance.arrayForCostAndPath?[1])
    }
}
