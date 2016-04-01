# CardinalHashMap
Helpful for navigating a 2D array using the Cardinal Directions (i.e. North, East, South, West).

### Usage:
```
let board3x3 = CardinalHashMap([[1,2,3], [4,5,6], [7,8,9]])!

board3x3[2, .West] // 1
board3x3[2] // [.South: 5, .East: 3, .West: 1]
board3x3[1, .North] // nil - out of bounds
board3x3[10] // nil - out of bounds

// You can also use IntercardinalDirections
board3x3[1, .NorthEast] // 5



// There are also collector methods for iterating while something is true (while can be excluded)
board3x3.collectFrom(1, direction: .South, while: { _ in true }) // [1,4,7]

// These are also available for IntercardinalDirections (while can be excluded)
board3x3.collectFrom(1, direction: .NorthEast, while: { _ in true }) // [1,5,9]

// You can also iterate in multiple directions at once
// Note: The returned objects will not be sorted, since we don't enforce Comparable if you need them sorted this is your responsibility.
board3x3.collectFrom(5, directions: [.South, .North]) // [2,5,8]

// Or intercardinal directions...
board3x3.collectFrom(5, directions: [.SouthEast, .NorthWest]) // [1,5,9]
```
