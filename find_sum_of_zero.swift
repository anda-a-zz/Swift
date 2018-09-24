//
//  assign_1_7_sumToZero.playground
//  A. Achimescu
//
//  This program will find and output all true statements between 1 to a user-inputted integer (up to 20)

import Foundation

// Ask the user for an integer greater than 0
func getInteger() -> Int {
    var value:Int = 0
    while true {
        // get value from user. Using optional input since readLine returns an optional string.
        guard let inputLine = readLine() else {
            fatalError("Unexpected end-of-file condition")
        }
        
        // attempt to convert the input string to an Int
        if let unwrappedInt = Int(inputLine) {
            // Only use the value inputted by the user if it's between 0 and 20
            if unwrappedInt >= 0 && unwrappedInt <= 20 {
                value = unwrappedInt
                break
            }
            else {
                print("`\(inputLine)` is not between 0 and 20 . Please enter an integer")
            }
        }
            // the input doesn't convert into an int
        else {
            print("`\(inputLine)` is not an integer. Please enter an integer")
        }
    }
    return value
}

// declare variables
var sum:Int = 0             // The sum of 1 +/- ... +/- n, soon to find out if the sum is equal to 0 or not
var rows:Int = 0            // the number of rows in the matrix
var columns:Int = 0         // the number of columns in the matrix
var numberInputted:Int = 0  // integer gotten from user between 1 and 20
var length:Int = 0          // the length (number of rows) of the matrix, used to define the size of the array
var numOfTruStat:Int = 0    // Counter of how many true statements there are, initilize as 0 in case there are none

// Ask the user for an int
print("Hi! Please enter an integer between 0 and 20!")

// get the integer from the user
numberInputted = getInteger()

// Since 1 and 2 have no true statements, skip the whole process and just output that there are no true statements
// Only continue on if the numberInputted is greater than 2
if numberInputted > 2 {
    
    //  defines the length of the array as 2^numberInputted, that many rows
    length = Int(pow(Double(2),Double(numberInputted)))
    
    // Define the array with a bunch of 0s so swift does not get confused when values are inserted
    // has "length" amount of rows and "numberInputted" amount of columns
    var a = Array(repeating: Array(repeating: 0, count:numberInputted), count:length)
    
    // Initialize the matrix            // What the matrix looks like with these numbers:
    a[0][0] = 1                         //  + 1, + 2, ...
    a[0][1] = 2                         //  - 1, + 2, ...
    a[1][0] = -1                        //  + 1, - 2, ...
    a[1][1] = 2                         //  - 1, - 2, ...
    a[2][0] = 1
    a[2][1] = -2
    a[3][0] = -1
    a[3][1] = -2
    
    // this for loop inputs +/- numbers in the array
    for n in 3..<(numberInputted + 1) {
        
        rows = Int(pow(Double(2),Double(n)))        // Increases each time the loop loops,
        columns = n
        
        // continue to build the array (copy same array below)
        for i in (rows/2)..<rows {
            for j in 0..<(columns - 1) {
                a[i][j] = a[i-rows/2][j]
            }
        }
        
        // continue to build the array (adding next number)
        for i in 0..<(rows/2) {
            a[i][columns-1] = n
        }
        for i in (rows/2)..<rows {
            a[i][columns-1] = 0 - n
        }
    }
    
    //printing array if the sum of the row is 0
    for i in 0..<rows {
        // redeclare the sum as 0 in order for the sum of each row to differ
        sum = 0
        
        // add the sum of all the elements in the row of the array
        for j in 0..<columns {
            sum = sum + a[i][j]
        }
        
        // print out the statements only if the sum is 0
        if sum == 0 {
            numOfTruStat += 1                       // add one to true statement counter
            
            for j in 0..<columns {
                if a[i][j] > 0 {                    // if the number in the array is greater than 0, place a +
                    print("+", terminator:"")
                }
                print(a[i][j], " ", terminator:"")  // print out the number in the array
            }
            print(" = 0");                          // finish the row and move on to the next
        }
    }

}

// Print the amount of true statements
print("There are", numOfTruStat, "true statements!")









