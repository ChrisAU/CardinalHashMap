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
    static func all() -> [CardinalDirection] {
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

extension CardinalHashMap {
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in that direction.
    /// - parameter object: First object to validate and iterate from.
    /// - parameter direction: `CardinalDirection` to travel in.
    /// - parameter while (Optional): Validate `object`, if `false` is returned function will exit and return. If not specified or nil is specified it will assume `true`.
    /// - returns: `object` and all other objects in that direction that pass `while` validation.
    public func collectFrom(object: T, direction: CardinalDirection, `while`: ((T) -> Bool)? = nil) -> [T] {
        var buffer = [T]()
        if hashMap[object] == nil {
            return buffer
        }
        if `while` == nil || `while`?(object) == true {
            buffer.append(object)
        }
        if let nextObject = hashMap[object]?[direction] {
            buffer += collectFrom(nextObject, direction: direction, while: `while`)
        }
        return buffer
    }
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in each direction given.
    /// - parameter object: First object to validate and iterate from.
    /// - parameter directions (Optional): `CardinalDirection` array, if nil is given it will assume all directions.
    /// - parameter while (Optional): Validate `object`, if `false` is returned function will exit and return. If not specified or nil is specified it will assume `true`.
    /// - returns: `object` and all other objects in given directions that pass `while` validation.
    public func collectFrom(object: T, directions: [CardinalDirection]? = nil, `while`: ((T) -> Bool)? = nil) -> [T] {
        var buffer = [T]()
        if hashMap[object] == nil {
            return buffer
        }
        if `while` == nil || `while`?(object) == true {
            buffer.append(object)
        }
        for direction in directions ?? CardinalDirection.all() {
            if let nextObject = hashMap[object]?[direction] {
                buffer += collectFrom(nextObject, direction: direction, while: `while`)
            }
        }
        return Array(Set(buffer))
    }
    
}