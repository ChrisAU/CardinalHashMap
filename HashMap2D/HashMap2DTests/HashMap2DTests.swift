//
//  HashMap2DTests.swift
//  HashMap2DTests
//
//  Created by Chris Nevin on 31/03/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import XCTest
@testable import HashMap2D

class HashMap2DTests: XCTestCase {
    
    func testHashMapNotUnique() {
        let objects = [[1,2,3], [3,5,6], [7,8,9]]
        XCTAssertNil(HashMap2D(objects))
    }
    
    func testHashMapObjectsValid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        XCTAssertNotNil(HashMap2D(objects))
    }
    
    func testHashMapNavigationValidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        XCTAssertEqual(hashMap[5, .East], 6)
        XCTAssertEqual(hashMap[5, .West], 4)
        XCTAssertEqual(hashMap[5, .North], 2)
        XCTAssertEqual(hashMap[5, .South], 8)
    }
    
    func testHashMapNavigationInvalidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        XCTAssertNil(hashMap[1, .West])
        XCTAssertNil(hashMap[3, .East])
        XCTAssertNil(hashMap[2, .North])
        XCTAssertNil(hashMap[8, .South])
    }
    
    func testHashMapInvalidItem() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        XCTAssertNil(hashMap[10])
        XCTAssertNil(hashMap[11, .North])
    }

}


// MARK:- Helpers

extension HashMap2DTests {
    
    func trueFunc(object: Int) -> Bool { return true }
    func falseFunc(object: Int) -> Bool { return false }
    
}


// MARK:- Collect From (Single Direction)

extension HashMap2DTests {

    func testHashMapCollectFromSingleDirectionPassedMultiple() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collected = hashMap.collectFrom(6, direction: .West, while: trueFunc)
        XCTAssertEqual(collected.sort(), objects[1])
    }
    
    func testHashMapCollectFromSingleDirectionPassedSingle() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collectedOne = hashMap.collectFrom(4, direction: .West, while: trueFunc)
        XCTAssertEqual(collectedOne, [4])
    }
    
    func testHashMapCollectFromSingleDirectionFailedInvalidObject() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let uncollectedInvalid = hashMap.collectFrom(10, direction: .West, while: trueFunc)
        XCTAssertEqual(uncollectedInvalid, [])
    }
    
    func testHashMapCollectFromSingleDirectionFailedFalseWhile() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let uncollected = hashMap.collectFrom(6, direction: .West, while: falseFunc)
        XCTAssertEqual(uncollected, [])
    }
    
}



// MARK:- Collect From (Multiple Directions)

extension HashMap2DTests {
    
    func testHashMapCollectFromAllDirectionsPassedMultiple() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collected = hashMap.collectFrom(5, while: trueFunc)
        XCTAssertEqual(collected.sort(), [2,4,5,6,8])
    }
    
    func testHashMapCollectFromMultipleDirectionsPassedSingle() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collectedOne = hashMap.collectFrom(1, directions: [.West, .North], while: trueFunc)
        XCTAssertEqual(collectedOne, [1])
    }
    
    func testHashMapCollectFromMultipleDirectionsPassedMultiple() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collected = hashMap.collectFrom(2, directions: [.West, .South], while: trueFunc)
        XCTAssertEqual(collected.sort(), [1,2,5,8])
    }
    
    func testHashMapCollectFromAllDirectionsFailedInvalidObject() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let collected = hashMap.collectFrom(10, while: trueFunc)
        XCTAssertEqual(collected.sort(), [])
    }
    
    func testHashMapCollectFromAllDirectionsFailedFalseWhile() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = HashMap2D(objects)!
        
        let uncollected = hashMap.collectFrom(6, while: falseFunc)
        XCTAssertEqual(uncollected, [])
    }
    
}
    