# CardinalHashMap
Helpful for navigating a 2D array using the Cardinal Directions (i.e. North, East, South, West)

Usage:
let board3x3 = CardinalHashMap([[1,2,3], [4,5,6], [7,8,9]])!

board3x3[2, .West] // 1
board3x3[2] // [.South: 5, .East: 3, .West: 1]
board3x3[1, .North] // nil - out of bounds
board3x3[10] // nil - out of bounds
