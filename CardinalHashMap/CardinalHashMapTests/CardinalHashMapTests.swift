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
        do {
            let _ = try CardinalHashMap(objects)
        }
        catch CardinalHashMapError.DuplicateItem {
            XCTAssertTrue(true)
        }
        catch {
            XCTFail()
        }
    }
    
    func testHashMapObjectsValid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        XCTAssertNotNil(try! CardinalHashMap(objects))
    }
    
    func testHashMapObjectsInvalidCount() {
        let objects: [[Int]] = [[]]
        do {
            let _ = try CardinalHashMap(objects)
        }
        catch CardinalHashMapError.UnbalancedMatrix {
            XCTAssertTrue(true)
        }
        catch {
            XCTFail()
        }
    }
    
    func testHashMapObjectsUnbalancedCount() {
        let objects: [[Int]] = [[1,2], [3,4,5]]
        do {
            let _ = try CardinalHashMap(objects)
        }
        catch CardinalHashMapError.UnbalancedMatrix {
            XCTAssertTrue(true)
        }
        catch {
            XCTFail()
        }
    }
    
    func testHashMapNavigationValidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap[5, .East], 6)
        XCTAssertEqual(hashMap[5, .West], 4)
        XCTAssertEqual(hashMap[5, .North], 2)
        XCTAssertEqual(hashMap[5, .South], 8)
    }
    
    func testHashMapNavigationInvalidRange() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertNil(hashMap[1, .West])
        XCTAssertNil(hashMap[3, .East])
        XCTAssertNil(hashMap[2, .North])
        XCTAssertNil(hashMap[8, .South])
        XCTAssertNil(hashMap[9, .SouthEast])
    }
    
    func testHashMapInvalidItem() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertNil(hashMap[10])
        XCTAssertNil(hashMap[11, .North])
    }
    
    // MARK: - Cardinal
    
    func testCardinalAll() {
        XCTAssertEqual(CardinalDirection.all(), [.North, .NorthEast, .NorthWest, .East, .South, .SouthEast, .SouthWest, .West])
    }
    
    func testHashMapCardinalCollection() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .South).sort(), [1,4,7])
        XCTAssertEqual(hashMap.collect(7, direction: .North).sort(), [1,4,7])
        XCTAssertEqual(hashMap.collect(6, direction: .West).sort(), [4,5,6])
        XCTAssertEqual(hashMap.collect(4, direction: .East).sort(), [4,5,6])
    }
    
    func testHashMapCardinalCollectionWhileTrue() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .South, while: { _ in true}).sort(), [1,4,7])
    }
    
    func testHashMapCardinalCollectionWhileFalse() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .South, while: { _ in false}), [])
    }
    
    func testHashMapCardinalCollectionMultipleDirections() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(4, directions: [.North, .South]).sort(), [1,4,7])
    }
    
    func testHashMapCardinalCollectionMultipleDirectionsWhileTrue() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(4, directions: [.North, .South], while: { _ in true}).sort(), [1,4,7])
    }
    
    func testHashMapCardinalCollectionMultipleDirectionsWhileFalse() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(4, directions: [.North, .South], while: { _ in false}), [])
    }
    
    func testHashMapCardinalCollectionMultipleDirectionsInvalid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(10, directions: [.North, .South]), [])
    }
    
    func testHashMapCardinalCollectionInvalid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(10, direction: .South), [])
    }
    
    // MARK: - Intercardinal
    
    func testHashMapObjectsIntercardinal() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap[5, .NorthWest], 1)
        XCTAssertEqual(hashMap[5, .NorthEast], 3)
        XCTAssertEqual(hashMap[5, .SouthEast], 9)
        XCTAssertEqual(hashMap[5, .SouthWest], 7)
    }
    
    func testHashMapIntercardinalCollection() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .SouthEast).sort(), [1,5,9])
        XCTAssertEqual(hashMap.collect(9, direction: .NorthWest).sort(), [1,5,9])
        XCTAssertEqual(hashMap.collect(3, direction: .SouthWest).sort(), [3,5,7])
        XCTAssertEqual(hashMap.collect(7, direction: .NorthEast).sort(), [3,5,7])
    }
    
    func testHashMapIntercardinalCollectionWhileTrue() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .SouthEast, while: { _ in true}).sort(), [1,5,9])
    }
    
    func testHashMapIntercardinalCollectionWhileFalse() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(1, direction: .SouthEast, while: { _ in false}), [])
    }
    
    func testHashMapIntercardinalCollectionMultipleDirections() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(5, directions: [.NorthWest, .SouthEast]).sort(), [1,5,9])
    }
    
    func testHashMapIntercardinalCollectionMultipleDirectionsWhileTrue() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(5, directions: [.NorthWest, .SouthEast], while: { _ in true }).sort(), [1,5,9])
    }
    
    func testHashMapIntercardinalCollectionMultipleDirectionsWhileFalse() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(5, directions: [.NorthWest, .SouthEast], while: { _ in false }), [])
    }
    
    func testHashMapIntercardinalCollectionMultipleDirectionsInvalid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(10, directions: [.NorthWest, .SouthEast]), [])
    }
    
    func testHashMapIntercardinalCollectionInvalid() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.collect(10, direction: .SouthEast), [])
    }
    
    // MARK: - Seed Fill
    
    func testHashMapSeedFill() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(1, directions: [.South, .SouthEast]).sort(), [1,4,5,7,8,9])
    }
    
    func testHashMapSeedFillAll() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(1, directions: [.South, .East]).sort(), objects.flatten().sort())
    }
    
    func testHashMapSeedFillOnlyNorthWest() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(5, directions: [.North, .West]).sort(), [1,2,4,5])
    }
    
    func testHashMapSeedFillOnlyNorthEast() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(5, directions: [.North, .East]).sort(), [2,3,5,6])
    }

    func testHashMapSeedFillOnlySouthEast() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(5, directions: [.South, .East]).sort(), [5,6,8,9])
    }
    
    func testHashMapSeedFillOnlySouthWest() {
        let objects = [[1,2,3], [4,5,6], [7,8,9]]
        let hashMap = try! CardinalHashMap(objects)!
        XCTAssertEqual(hashMap.seedFill(5, directions: [.South, .West]).sort(), [4,5,7,8])
    }

}
