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
    case NorthEast
    case NorthWest
    case East
    case South
    case SouthEast
    case SouthWest
    case West
    public static func all() -> [CardinalDirection] {
        return [.North, .NorthEast, .NorthWest, .East, .South, .SouthEast, .SouthWest, .West]
    }
    internal func toCardinalDirections() -> [CardinalDirection] {
        switch self {
        case .NorthEast: return [.North, .East]
        case .NorthWest: return [.North, .West]
        case .SouthEast: return [.South, .East]
        case .SouthWest: return [.South, .West]
        default:         return [self]
        }
    }
}

public enum CardinalHashMapError: ErrorType {
    /// Thrown when the sub-arrays have different number of items in them or zero items.
    case UnbalancedMatrix
    /// Thrown when the array contains a duplicate item.
    case DuplicateItem
}

public struct CardinalHashMap<T: Hashable> {
    typealias CardinalHashMapType = [T: [CardinalDirection: T]]
    private let hashMap: CardinalHashMapType
    
    /// Initializes a hashmap with the given objects, will fail if items are not unique or sub-arrays are unbalanced.
    public init?(_ objects: [[T]]) throws {
        if let count = objects.first?.count where count > 0 {
            for items in objects where items.count != count {
                throw CardinalHashMapError.UnbalancedMatrix
            }
        } else {
            throw CardinalHashMapError.UnbalancedMatrix
        }
        
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
                    throw CardinalHashMapError.DuplicateItem
                }
                tempMap[item] = directions
            }
        }
        hashMap = tempMap
    }
    
    public subscript(object: T, direction: CardinalDirection) -> T? {
        var output: T? = object
        for dir in direction.toCardinalDirections() where output != nil {
            output = hashMap[output!]?[dir]
        }
        return object == output ? nil : output
    }
    
    public subscript(object: T) -> [CardinalDirection: T]? {
        return hashMap[object]
    }
    
}
