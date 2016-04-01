//
//  CardinalHashMap+Intercardinal.swift
//  CardinalHashMap
//
//  Created by Chris Nevin on 1/04/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import Foundation

public enum IntercardinalDirection {
    case NorthEast
    case NorthWest
    case SouthEast
    case SouthWest
    public static func all() -> [IntercardinalDirection] {
        return [.NorthEast, .NorthWest, .SouthEast, .SouthWest]
    }
    func toCardinalDirections() -> [CardinalDirection] {
        switch self {
        case .NorthEast: return [.North, .East]
        case .NorthWest: return [.North, .West]
        case .SouthEast: return [.South, .East]
        case .SouthWest: return [.South, .West]
        }
    }
}

extension CardinalHashMap {
    
    public subscript(object: T, intercardinalDirection: IntercardinalDirection) -> T? {
        var output = object
        for direction in intercardinalDirection.toCardinalDirections() {
            guard let newValue = self[output, direction] else {
                return nil
            }
            output = newValue
        }
        return output != object ? output : nil
    }
    
}

