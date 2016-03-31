//
//  HashMap2D.swift
//  HashMap2D
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

public struct HashMap2D<T: Hashable> {
    typealias HashMap2DType = [T: [CardinalDirection: T]]
    private let hashMap: HashMap2DType
    
    /// Initializes a hashmap with the given objects, will fail if items are not unique.
    init?(_ objects: [[T]]) {
        var tempMap = HashMap2DType()
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
    
    subscript(object: T, direction: CardinalDirection) -> T? {
        return hashMap[object]?[direction]
    }
    
    subscript(object: T) -> [CardinalDirection: T]? {
        return hashMap[object]
    }
}

public extension HashMap2D {
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in that direction.
    /// - parameter object: First object to validate and iterate from.
    /// - parameter direction: `CardinalDirection` to travel in.
    /// - parameter while: Validate `object`, if `false` is returned function will exit and return.
    /// - returns: `object` and all other objects in that direction that pass `while` validation.
    func collectFrom(object: T, direction: CardinalDirection, `while`: (T) -> Bool) -> [T] {
        var buffer = [T]()
        if hashMap[object] == nil {
            return buffer
        }
        if `while`(object) {
            buffer.append(object)
        }
        if let nextObject = hashMap[object]?[direction] {
            buffer += collectFrom(nextObject, direction: direction, while: `while`)
        }
        return buffer
    }
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in each direction given.
    /// - parameter object: First object to validate and iterate from.
    /// - parameter directions: `CardinalDirection` array, if nil is given it will assume all directions.
    /// - parameter while: Validate `object`, if `false` is returned function will exit and return.
    /// - returns: `object` and all other objects in given directions that pass `while` validation.
    func collectFrom(object: T, directions: [CardinalDirection]? = nil, `while`: (T) -> Bool) -> [T] {
        var buffer = [T]()
        if hashMap[object] == nil {
            return buffer
        }
        if `while`(object) {
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