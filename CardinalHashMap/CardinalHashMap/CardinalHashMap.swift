//
//  CardinalHashMap.swift
//  CardinalHashMap
//
//  Created by Chris Nevin on 31/03/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import Foundation

public enum CardinalDirection {
    case North
    case East
    case South
    case West
    public static func all() -> [CardinalDirection] {
        return [.North, .East, .South, .West]
    }
}

public struct CardinalHashMap<T: Hashable> {
    typealias CardinalHashMapType = [T: [CardinalDirection: T]]
    private let hashMap: CardinalHashMapType
    
    /// Initializes a hashmap with the given objects, will fail if items are not unique.
    public init?(_ objects: [[T]]) {
        var tempMap = CardinalHashMapType()
        for (row, items) in objects.enumerate() {
            for (column, item) in items.enumerate() {
                var directions = [CardinalDirection: T]()
                if row > 0 {
                    directions[.North] = objects[row-1][column]
                }
                if row < objects.count - 1 {
                    directions[.South] = objects[row+1][column]
                }
                if column > 0 {
                    directions[.West] = objects[row][column-1]
                }
                if column < items.count - 1 {
                    directions[.East] = objects[row][column+1]
                }
                if tempMap[item] != nil {
                    return nil
                }
                tempMap[item] = directions
            }
        }
        hashMap = tempMap
    }
    
    public subscript(object: T, direction: CardinalDirection) -> T? {
        return hashMap[object]?[direction]
    }
    
    public subscript(object: T) -> [CardinalDirection: T]? {
        return hashMap[object]
    }
    
}
