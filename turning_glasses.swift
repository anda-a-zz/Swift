//
//  assign_2_5_turningOverGlasses.playground
//
//  A. Achimescu
//
//  This program will turn over n cups fully in k moves by turning over q cups each move
//  (k is given in the statement: "All glasses turned in k moves")
//
//  For a better representation, in printGlasses function, follow the comments


import Foundation

// turn glass
// glass = 0 - upside down (⋂)
// glass = 1 - turned up   (⋃)

func turn (_ glassOriginal:Int) -> Int {
    var glass:Int = glassOriginal
    
    // turn the glass by changing the number
    if glass == 0 {
        glass = 1
    }
    else {
        glass = 0
    }
    return glass
}

// print array that store glasses state
// change 0 and 1 to ⋂ and ∪ respectively

func printGlasses(_ glassesArray:[Int], _ n:Int) {
    var glass:Character = " " // initialize
    
    for i in 0..<n {
        if glassesArray[i] == 1 {
            glass = "⋃"
        }
        else {
            glass = "⋂"
        }
        // to better see the glasses, use the following line of code:
        // print(glassesArray[i], " ", terminator:"")
        // it will be more noticable with the 0s and 1s
        
        print(glass, " ", terminator:"")
    }
    print(" ")
}

// algorithm for when n/q >= 2, even remainder, and n/q + 1 # of steps
func algorithm1(_ n:Int, _ q:Int) {
    var glassesArray = Array(repeating: 0, count: n) // An array to store glasses state (currently all upside down)
    let remainder = n % q
    var counter:Int = 0
    
    // print the empty array of just unflipped glasses
    printGlasses(glassesArray, n)
    
    // turn the glasses from first to last, but leaving the reminder # of glasses unturned
    for j in 0..<(n/q - 1) {
        for i in (q*j)..<( j + 1)*q {
            glassesArray[i] = turn(glassesArray[i])
        }
        printGlasses(glassesArray, n)
        counter += 1
    }
    
    // continue to turn glasses, except now there's a shift back by (q - remainder)/2
    for i in 1...q {
        // need to turn glasses up from 1 "(q - remainder)/2" glasses
        glassesArray[(n - q - remainder - 1) - (q - remainder)/2 + i] = turn(glassesArray[(n - q - remainder - 1) - (q - remainder)/2 + i])
    }
    
    printGlasses(glassesArray, n)
    counter += 1
    
    // last state: turn up all glasses
    for i in 0..<n {
        glassesArray[i] = 1
    }
    
    printGlasses(glassesArray, n)
    counter += 1
    
    // done in n/q+1 moves
    print("All glasses turned in", counter, "moves")
}

//algorithm for q<n-1; remainder even and also contain perfect case reminder=0
func algorithm2(_ n:Int, _ q:Int) {
    var glassesArray = Array(repeating: 0, count: n) // An array to store glasses state (currently all upside down)
    let remainder:Int = n % q
    var counter:Int = 0
    
    // print the empty array of unflipped glasses
    printGlasses(glassesArray, n)
    
    // turn the glasses from first to last, but leaving the reminder # of glasses unturned
    for j in 0..<(n/q) {
        for i in (q*j)..<((j + 1)*q) {
            glassesArray[i] = turn(glassesArray[i])
        }
        printGlasses(glassesArray, n)
        counter += 1
    }
    
    // if remainder is 0 problem is already solved above
    if remainder > 0
    {
        //turn  glasses from the other end - remainder must be even for this solution
        for i in 1...q {
            glassesArray[n - remainder/2 - i] = turn(glassesArray[n - remainder/2 - i]) // turn up "remainder/2" # of glasses
        }
        printGlasses(glassesArray, n)
        counter += 1
        
        // last state: turn up all glasses
        for i in 0..<n {
            glassesArray[i] = 1
        }
        printGlasses(glassesArray, n)
        counter += 1
        
        // done in n/q + 2 moves
        print("All glasses turned in", counter, "moves")
    }
    else {
        // done in n/q moves
        print("All glasses turned in", counter, "moves")
    }
}

// algorithm for q < (n - 1)
// particular case when rem odd and n/q = 1
func algorithm3(_ n:Int, _ q:Int) {
    var glassesArray = Array(repeating: 0, count: n) // An array to store glasses state (currently all upside down)
    let remainder:Int = n % q
    var counter:Int = 0           // counts number of moves
    var countThe0s:Int = 0        // how many 0s in the row
    var countThe1s:Int = 0        // how many 1s in the row
    
    // print the empty array of unflipped glasses
    printGlasses(glassesArray, n)
    
    // turn the glasses from first to last, but leaving the reminder # of glasses unturned
    for j in 0..<(n/q) {
        for i in (q*j)..<((j + 1)*q) {
            glassesArray[i] = turn(glassesArray[i])
        }
        printGlasses(glassesArray, n)
        counter += 1
    }
    
    for i in 0..<remainder {
        // turn up the last glasses
        // then start from the first and turn them back down
        glassesArray[n - remainder + i] = turn(glassesArray[n - remainder + i])
    }
    
    // turn up from the begining the rest up to q
    for i in 0..<(q - remainder) {
        glassesArray[i] = turn(glassesArray[i])
    }
    printGlasses(glassesArray, n)
    counter += 1
    
    countThe0s = n - 2*remainder       // find the # of 0s in the line / move
    
    // exit once theres LESS zeros than twice the originial remainder in the step
    while (countThe0s > 2*remainder) {
        
        //step 1
        countThe1s = n - countThe0s     // find the # of 1s in the line / move
        
        // turning over glasses in function of the 1s
        for i in 0..<countThe1s {
            glassesArray[n - countThe1s + i] = turn(glassesArray[n - countThe1s + i])
        }
        
        for i in 0..<(q - countThe1s) {
            glassesArray[i] = turn(glassesArray[i])
        }
        printGlasses(glassesArray, n)
        counter += 1
        
        //step 2
        countThe1s = q - countThe1s
        countThe0s = n - countThe1s
        
        // turning over glasses in function of the 0s
        for i in 0..<countThe0s {
            glassesArray[n - countThe0s + i] = turn(glassesArray[n - countThe0s + i])
        }
        
        for i in 0..<(q - countThe0s) {
            glassesArray[i] = turn(glassesArray[i])
        }
        printGlasses(glassesArray, n)
        counter += 1
        
        // change this up for when it loops around + exits
        countThe0s = n - counter*remainder
    }
    
    // turn glasses from start
    // remainder must be even for this solution
    for i in 0..<q {
        glassesArray[countThe0s/2 + i] = turn(glassesArray[countThe0s/2 + i])
    }
    printGlasses(glassesArray, n)
    counter += 1
    
    // last state: turn up all glasses
    for i in 0..<n {
        glassesArray[i] = 1
    }
    printGlasses(glassesArray, n)
    counter += 1
    
    print("All glasses turned in", counter, "moves")
}

// algorithm for q = n - 1
// n is even
func algorithmn_1(_ n:Int) {
    var glassesArray = Array(repeating: 0, count: n) // An array to store glasses state (currently all upside down)
    var counter:Int = 0
    var holdvalue:Int = 0                            // will remember the previous value
    
    printGlasses(glassesArray, n)
    
    for j in 0..<n {
        holdvalue = glassesArray[j]
        
        // turn all glasses form start but # j
        for i in 0..<n {
            glassesArray[i] = turn(glassesArray[i])
        }
        glassesArray[j] = holdvalue
        printGlasses(glassesArray, n)
        counter += 1
    }
    print("All glasses turned in", counter, "moves")
}

// Get a positive integer from the user
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
            } else {
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

// ask user for number of cups and how many flips per move
print("Hello. Please input the number of cups you would like to start with.")
var n:Int = getInteger()    // number of glasses

print("Thank you! Now please input how many glasses can be turned in one move.")
var q:Int = 0               // initialize

// making sure that q is < n
repeat {
    q = getInteger()         // how many glasses can be turnd in one move
    if q >= n {
        print("I'm sorry but", q, "is not smaller than", n, "Please input another number.")
    }
} while q >= n

var remainder:Int = n % q
print("There are", n, "glasses. Turn", q, "glasses in each move")

// choosing the algorithm pathway

// if n is odd but q is even
if n % 2 == 1 && q % 2 == 0 {
    print("There is no solution")
}
    // if there is no reminder
else if remainder == 0{
    algorithm2(n, q)
}
else {
    // if q is one off from n
    if q == (n - 1) {
        algorithmn_1(n)
    }
    else {
        // if the remainder is even...
        if (remainder % 2) == 0 {
            // if q is odd OR (n/q) == 1
            if q % 2 == 1 || (n/q) == 1 {
                algorithm2(n, q)
            }
            else {
                algorithm1(n, q)
            }
        }
            // remainder is odd...
        else {
            // if (n/q) == 1
            if (n/q) == 1 {
                algorithm3(n, q)
            }
            else {
                algorithm1(n, q)
            }
        }
    }
}

// checking for errors

/* TEST 1 - algorithm 2
 Hello. Please input the number of cups you would like to start with.
 -0
 `-0` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 why man
 `why man` is not an integer. Please enter an integer
 :(
 `:(` is not an integer. Please enter an integer
 fine 556
 `fine 556` is not an integer. Please enter an integer
 45
 Thank you! Now please input how many glasses can be turned in one move.
 9
 There are 45 glasses. Turn 9 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 5 moves
 Program ended with exit code: 0 */

/* TEST 2 - algorithm n - 1
 Hello. Please input the number of cups you would like to start with.
 6
 Thank you! Now please input how many glasses can be turned in one move.
 7
 I'm sorry but 7 is not smaller than 6 Please input another number.
 7
 I'm sorry but 7 is not smaller than 6 Please input another number.
 6
 I'm sorry but 6 is not smaller than 6 Please input another number.
 5
 There are 6 glasses. Turn 5 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 6 moves
 Program ended with exit code: 0 */

/* TEST 3 - algorthim 3
 Hello. Please input the number of cups you would like to start with.
 -0
 `-0` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 -21
 `-21` is not greater than 0. Please enter an integer
 24
 Thank you! Now please input how many glasses can be turned in one move.
 25
 I'm sorry but 25 is not smaller than 24 Please input another number.
 26
 I'm sorry but 26 is not smaller than 24 Please input another number.
 21
 There are 24 glasses. Turn 21 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋂  ⋂  ⋂  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 8 moves
 Program ended with exit code: 0 */

// algorithm 1


/* TEST 1 - rem even, n/q >= 2
 Hello. Please input the number of cups you would like to start with.
 10
 Thank you! Now please input how many glasses can be turned in one move.
 4
 There are 10 glasses. Turn 4 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋂  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 3 moves
 Program ended with exit code: 0 */

/* TEST 2 - rem odd, n/q >= 2
 Hello. Please input the number of cups you would like to start with.
 7
 Thank you! Now please input how many glasses can be turned in one move.
 3
 There are 7 glasses. Turn 3 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋂  ⋃  ⋃  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 3 moves
 Program ended with exit code: 0 */

/* TEST 3 - rem odd, n/q >= 2
 Hello. Please input the number of cups you would like to start with.
 10
 Thank you! Now please input how many glasses can be turned in one move.
 3
 There are 10 glasses. Turn 3 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋃  ⋃  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 4 moves
 Program ended with exit code: 0 */


// algorithm 2


/* TEST 1 - rem even, n/q = 1
 Hello. Please input the number of cups you would like to start with.
 6
 Thank you! Now please input how many glasses can be turned in one move.
 4
 There are 6 glasses. Turn 4 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂
 ⋃  ⋂  ⋂  ⋂  ⋃  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 3 moves
 Program ended with exit code: 0
 */

/* TEST 2 - rem even, doesn't matter if n/q >= 2
 Hello. Please input the number of cups you would like to start with.
 8
 Thank you! Now please input how many glasses can be turned in one move.
 3
 There are 8 glasses. Turn 3 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋃  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 4 moves
 Program ended with exit code: 0 */

/* TEST 3 - rem even
 Hello. Please input the number of cups you would like to start with.
 5
 Thank you! Now please input how many glasses can be turned in one move.
 3
 There are 5 glasses. Turn 3 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋂  ⋂
 ⋃  ⋂  ⋂  ⋃  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 3 3 moves
 Program ended with exit code: 0 */

/* TEST 4 - rem = 0
 Hello. Please input the number of cups you would like to start with.
 8
 Thank you! Now please input how many glasses can be turned in one move.
 4
 There are 8 glasses. Turn 4 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 2 moves
 Program ended with exit code: 0 */


// algorithm 3


/* TEST 1
 Hello. Please input the number of cups you would like to start with.
 8
 Thank you! Now please input how many glasses can be turned in one move.
 5
 There are 8 glasses. Turn 5 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋂  ⋃  ⋂  ⋂  ⋂  ⋂  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 4 moves
 Program ended with exit code: 0 */

/* TEST 2 - with 1s and 0s, if the one piece of code is used (in printGlasses)
 Hello. Please input the number of cups you would like to start with.
 100
 Thank you! Now please input how many glasses can be turned in one move.
 87
 There are 100 glasses. Turn 87 glasses in each move
 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 0  0  0  0  0  0  0  0  0  0  0  1  1  1  1  1  1  1  1  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  1
 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 All glasses turned in 8 moves
 Program ended with exit code: 0 */


// algorithm n-1 (algorithmn_1)


/* TEST 1 - n glasses, n-1 turns per move
 Hello. Please input the number of cups you would like to start with.
 8
 Thank you! Now please input how many glasses can be turned in one move.
 7
 There are 8 glasses. Turn 7 glasses in each move
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋃  ⋃  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋂  ⋂  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋃  ⋃  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋂  ⋂
 ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋂  ⋃
 ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃  ⋃
 All glasses turned in 8 moves
 Program ended with exit code: 0 */


// no solution

/* TEST 1
 Hello. Please input the number of cups you would like to start with.
 3
 Thank you! Now please input how many glasses can be turned in one move.
 2
 There are 3 glasses. Turn 2 glasses in each move
 There is no solution
 Program ended with exit code: 0 */



