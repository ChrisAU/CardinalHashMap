//
//  CardinalHashMapTests.swift
//  CardinalHashMapTests
//
//  Created by Chris Nevin on 31/03/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import XCTest
@testable import CardinalHashMap

class CardinalHashMapTests: XCTestCase {
    
    func testHashMapNotUnique() {
        let objects = [[1,2,3], [3,5,6], [7,8,9]]
        XCTAssertNil(CardinalHashMap(objects))
    }
    
    func testHashMapObjectsValid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        XCTAssertNotNil(CardinalHashMap(objects))
    }
    
    func testHashMapNavigationValidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = CardinalHashMap(objects)!
        XCTAssertEqual(hashMap[5, .East], 6)
        XCTAssertEqual(hashMap[5, .West], 4)
        XCTAssertEqual(hashMap[5, .North], 2)
        XCTAssertEqual(hashMap[5, .South], 8)
    }
    
    func testHashMapNavigationInvalidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = CardinalHashMap(objects)!
        XCTAssertNil(hashMap[1, .West])
        XCTAssertNil(hashMap[3, .East])
        XCTAssertNil(hashMap[2, .North])
        XCTAssertNil(hashMap[8, .South])
    }
    
    func testHashMapInvalidItem() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = CardinalHashMap(objects)!
        XCTAssertNil(hashMap[10])
        XCTAssertNil(hashMap[11, .North])
    }
    
    func testHashMapObjectsIntercardinal() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = CardinalHashMap(objects)!
        XCTAssertEqual(hashMap[5, .NorthWest], 1)
        XCTAssertEqual(hashMap[5, .NorthEast], 3)
        XCTAssertEqual(hashMap[5, .SouthEast], 9)
        XCTAssertEqual(hashMap[5, .SouthWest], 7)
    }
    
}
