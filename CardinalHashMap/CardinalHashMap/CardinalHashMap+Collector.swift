//
//  CardinalHashMap+Collector.swift
//  CardinalHashMap
//
//  Created by Chris Nevin on 1/04/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import Foundation

extension CardinalHashMap {
    
    private func loop(start: T, directions: [CardinalDirection], seeded: Bool, `while`: ((T) -> Bool)? = nil) -> [T] {
        var buffer = [T]()
        if self[start] == nil {
            return buffer
        }
        if `while` == nil || `while`?(start) == true {
            buffer.append(start)
        }
        for direction in directions {
            if let nextObject = self[start, direction] {
                buffer += loop(nextObject, directions: seeded ? directions : [direction], seeded: seeded, while: `while`)
            }
        }
        return Array(Set(buffer))
    }
    
    /// Perform the seed fill (or flood fill) algorithm in a given number of directions.
    /// - parameter start: Object to start from.
    /// - parameter directions: `CardinalDirection` array, each item that is found will fill in these directions as well.
    /// - parameter while (Optional): Only iterate while this function is true.
    /// - returns: Unsorted items that were found.
    public func seedFill(start: T, directions: [CardinalDirection], `while`: ((T) -> Bool)? = nil) -> [T] {
        return loop(start, directions: directions, seeded: true, while: `while`)
    }
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in that direction.
    /// - parameter start: First object to validate and iterate from.
    /// - parameter direction: `CardinalDirection` to travel in.
    /// - parameter while (Optional): Validate `object`, if `false` is returned function will exit and return. If not specified or nil is specified it will assume `true`.
    /// - returns: `object` and all other objects in that direction that pass `while` validation.
    public func collect(start: T, direction: CardinalDirection, `while`: ((T) -> Bool)? = nil) -> [T] {
        return collect(start, directions: [direction], while: `while`)
    }
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in each direction given.
    /// - parameter start: First object to validate and iterate from.
    /// - parameter directions: `CardinalDirection` array.
    /// - parameter while (Optional): Validate `object`, if `false` is returned function will exit and return. If not specified or nil is specified it will assume `true`.
    /// - returns: `object` and all other objects in given directions that pass `while` validation.
    public func collect(start: T, directions: [CardinalDirection], `while`: ((T) -> Bool)? = nil) -> [T] {
        return loop(start, directions: directions, seeded: false, while: `while`)
    }
    
}