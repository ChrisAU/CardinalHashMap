//
//  CardinalHashMap+Collector.swift
//  CardinalHashMap
//
//  Created by Chris Nevin on 1/04/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import Foundation

extension CardinalHashMap {
    
    /// Iterate in direction as long as `while` passes and it is possible to navigate in that direction.
    /// - parameter object: First object to validate and iterate from.
    /// - parameter direction: `CardinalDirection` to travel in.
    /// - parameter while (Optional): Validate `object`, if `false` is returned function will exit and return. If not specified or nil is specified it will assume `true`.
    /// - returns: `object` and all other objects in that direction that pass `while` validation.
    public func collectFrom(object: T, direction: CardinalDirection, `while`: ((T) -> Bool)? = nil) -> [T] {
        var buffer = [T]()
        if self[object] == nil {
            return buffer
        }
        if `while` == nil || `while`?(object) == true {
            buffer.append(object)
        }
        if let nextObject = self[object, direction] {
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
        if self[object] == nil {
            return buffer
        }
        if `while` == nil || `while`?(object) == true {
            buffer.append(object)
        }
        for direction in directions ?? CardinalDirection.all() {
            if let nextObject = self[object, direction] {
                buffer += collectFrom(nextObject, direction: direction, while: `while`)
            }
        }
        return Array(Set(buffer))
    }
    
}