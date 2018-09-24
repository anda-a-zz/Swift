//
//  assign_1_4_searchTimeFromRandom
//
//  A. Achimescu
//
//  This program will compares the time it takes to search for random number from a random set of double inputs as the number of inputs grows.
//  This program will find the elapsed time for swift using standard libraries.
//  This program will not include time to print text in its calculations.
//  This program will verify the linear versus logarithmic (binary) growth of the two search algorithms.

import Foundation

// Ask the user for an integer greater than 0
// This number of doubles will be randomly inputed by the computer in order to determine the time it takes for a random number to be searched for
func getInteger() -> Int {
    var value:Int = 0
    while true {
        // get value from user. Using optional input since readLine returns an optional string.
        guard let inputLine = readLine() else {
            fatalError("Unexpected end-of-file condition")
        }
        
        // attempt to convert the input string to an Int
        if let unwrappedInt = Int(inputLine) {
            if unwrappedInt > 0 {
                value = unwrappedInt
                break
            }
            else {
                print("`\(inputLine)` is not greater than 0. Please enter an integer")
            }
        }
        // the input doesn't convert into an int
        else {
            print("`\(inputLine)` is not an integer. Please enter an integer")
        }
    }
    return value
}

// Binary Search Function
func binarySearch(_ numbers:[Double], key:Double) {
    let start = NSDate()                            // Start the timer
    
    // First and last digits in the array
    var first = 0
    var last = numbers.count - 1
    
    while first <= last {
        let mid = (first + last) / 2                // compute mid point.
        if Double(key) > numbers[mid] {
            first = mid + 1                         // repeat search in top half.
        } else if Double(key) < numbers[mid] {
            last = mid - 1                          // repeat search in bottom half.
        } else {
            // This would usually be when the position of the array is found and returned back to main
            // Instead, stop the timer and print how long it took for the computer to search
            let end = NSDate()
            let timeInterval: Double = end.timeIntervalSince(start as Date)
            print("It took binary search:", timeInterval, "seconds to find a random key in an array")
            break
        }
    }
}

// Linear Search Function
func linearSearch(_ numbers:[Double], key:Double) {
    let start = NSDate()    // Start the timer
    
    // Search the array to find the key
    for (_, value) in numbers.enumerated() {
        if value == Double(key) {
            // Would have returned a value, except this function only needs to print out the time it takes to find the number
            // Instead, stop the timer and print how long it took for the computer to search
            let end = NSDate()
            let timeInterval: Double = end.timeIntervalSince(start as Date)
            print("It took linear search:", timeInterval, "seconds to find a random key in an array")
        }
    }
}

var numOfRandomDouble:Int = 0
// Ask the user for an interger
print("Hello! Please enter an integer greater than 0!")
numOfRandomDouble = getInteger()
print ("Thank you! That's how many elements will be in the random double array!")

// Define these variables
var randomDouble:Double = 0                 // The random double will be assigned to this variable, has no value currently
var randomDoubleArray:[Double] = []         // The random double array used in loop, is empty currently

// Make a loop that constant inserts doubles inside until there's numOfRandomDouble number of doubles inside
// While the counter is still smaller than the number inputted by the user, keep inserting new doubles into the array

for _ in 0..<numOfRandomDouble {
    randomDouble = drand48()                 // This function assigns a random number to this variable, randomDouble
    randomDoubleArray.append(randomDouble)   // Add the random double into the array
}

// Come up with a random element in the array
let elementInArray:Int = Int(arc4random_uniform(UInt32(randomDoubleArray.count - 0 + 1)))
// Let this be the random value being searched for
let key = randomDoubleArray[elementInArray]

// Sort the random array
randomDoubleArray.sort()

// Find the time for binary and linear search to compare
binarySearch(randomDoubleArray, key: key)
linearSearch(randomDoubleArray, key: key)

/* TEST 1
 Hello! Please enter an integer greater than 0!
 -9
 `-9` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 ******
 `******` is not an integer. Please enter an integer
 00009
 Thank you! That's how many elements will be in the random double array!
 It took binary search: 2.30073928833008e-05 seconds to find a random key in an array
 It took linear search: 0.00104701519012451 seconds to find a random key in an array
 Program ended with exit code: 0 */

/* TEST 2
Hello! Please enter an integer greater than 0!
8000
Thank you! That's how many elements will be in the random double array!
It took binary search: 8.94069671630859e-06 seconds to find a random key in an array
It took linear search: 0.00111305713653564 seconds to find a random key in an array
Program ended with exit code: 0 */


