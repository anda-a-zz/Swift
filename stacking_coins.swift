//
//  A. Achimescu
//  assign_2_3_stackingCoins.playground
//
//
//  This program will stack up coins in a pyramid shape, with user given positive integer n being the number of rows on the very bottom
//  Will show each solution with n on the bottom

import Foundation

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
            if unwrappedInt > 0 && unwrappedInt < 11{
                value = unwrappedInt
                break
            } else {
                print("`\(inputLine)` is not greater than 0 or less than 11. Please enter an integer")
            }
        }
            // the input doesn't convert into an int
        else {
            print("`\(inputLine)` is not an integer. Please enter an integer")
        }
    }
    return value
}

// ask user for number of coins
print("Hello! Please enter the number of coins you would like to be on the bottom of the stacked pyramid.")

// btw, this program will run for about 6 min if n = 10
var nMax:Int = getInteger()
var counter:Int = 0

// transform 0 or 1 into "o" ("o" for coin)
// title "zerone" is a mix between zero and one
func transform0and1(_ zerone:Int) -> Character {
    var answer:Character
    if zerone == 1 {
        answer = "o"
    }
    else {
        answer = " "
    }
    return answer
}

// build a 3D array with all possible permutation of 0 and 1 for each number from 1 to n-1
func buildArray(_ n:Int) -> [Array<Array<Int>>] {
    
    var nTemp:Int = Int(pow(Double(2),Double(n)))
    var coinArray = Array(repeating: Array(repeating: Array(repeating: 0, count:n), count: nTemp), count:n)
    
    // makes last filled with coins
    for j in 0..<n {
        coinArray[n - 1][0][j] = 1
    }
    
    // store "slices" of possible permutation for 0,1 (n=1 goes to k=0 and n=9 goes to k=8
    for k in stride(from: n-2, to: -1, by: -1) {
        nTemp = Int(pow(Double(2),Double(k+1)))
        
        for i in 0..<nTemp {
            for j in 0..<(k+1) {
                if (i >> j) % 2 != 0 {
                    coinArray[k][i][j] = 1
                } else
                {
                    coinArray[k][i][j] = 0
                }
            }
        }
    }
    return coinArray
}

// build an array filled with 0 except last row filled with 1
// will be used to iterate all permutations made by buildArray
func buildEmptyArray()-> Array<Array<Int>> {
    var coinArray = Array(repeating: Array(repeating: 0, count: nMax), count: nMax)
    
    for j in 0..<nMax {
        coinArray[n - 1][j] = 1
    }
    return coinArray
}

// add a gap between coins to allow the coin on row above to sits on two coins
// also shifts the values to the right on each row
func transformShift(coinArray:Array<Array<Int>>) -> Array<Array<Int>> {
    var coinArrayTransformed = Array(repeating: Array(repeating: 0, count: 2*nMax), count: nMax)
    
    for i in 0..<nMax {
        for j in 0..<i+1 {
            coinArrayTransformed[i][j*2 + nMax - i - 1] = coinArray[i][j];
        }
    }
    return coinArrayTransformed
}

// recursively creates an array with last row of only 1s and the other permutations of 0/1 on the other rows
// ie: if the number is 10 row 0 has permutations of 1 , row 8 has permutation of 9
func printArray(n:Int, coinArrayResult:Array<Array<Int>>, coinArray:[Array<Array<Int>>]) {
    let nTemp:Int = Int(pow(Double(2),Double(nMax - n + 1)))
    var coinArrayResult2 = coinArrayResult // create a new array to change
    
    if n == 1 {
        var check:Int = 1
        // check for excess 0s and any coins that are "floating" (any 1s ontop of 0s)
        for i in 1..<(nMax - 1) {
            for j in 0..<(i + 1) {
                
                // exclude bad solutions before printing
                // check the other conditions that didn't work recurseviley
                if (coinArrayResult2[i - 1][j] == 1 ) && (coinArrayResult2[i][j + 1] == 0 ) {
                    check = 0
                    break
                }
            }
        }
        // only print if it passed the previous checking loop
        if check == 1 {
            // new array is printed with gaps between coins and shifts
            var coinArrayResult3 = transformShift(coinArray: coinArrayResult2)
            
            for i in 0..<nMax {               // to how many rows
                for j in 0..<2*nMax {         // to how many columns
                    print(transform0and1(coinArrayResult3[i][j]), terminator:"")
                }
                print("")
            }
            print("")
            counter = counter + 1
        }
    }
        
    else
    {
        var check:Int = 1
        // assign starting with row 0
        for i in 0..<nTemp {
            check = 1
            for j in 0..<(nMax - n + 1){ //to how many columns
                coinArrayResult2[nMax - n][j] = coinArray[nMax - n][i][j]
                
                // if 1 sits on 0, then the "solution" should not be printed !
                if n < nMax{
                    if ((coinArrayResult2[nMax - n][j] == 0) && coinArrayResult2[nMax - n - 1][j] == 1)  {
                        check = 0
                        break
                    }
                }
            }
            if check == 1 {
                printArray(n: n-1, coinArrayResult: coinArrayResult2, coinArray: coinArray)
            }
        }
    }
}

// make and print array
var n:Int = nMax
var arrayUsed = buildArray(nMax)
printArray(n: n, coinArrayResult: buildEmptyArray(), coinArray: arrayUsed)

// print number of solutions
print ("There are", counter, "solutions")

// when you run the code, the shape of the triangles are more like a pyramid than a right angled triangle!! it just copy pastes oddly

/* TEST 1
 Hello! Please enter the number of coins you would like to be on the bottom of the stacked pyramid.
 -0
 `-0` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 [09]
 `[09]` is not an integer. Please enter an integer
 4
 
 
 
 o o o o
 
 
 
 o
 o o o o
 
 
 
 o
 o o o o
 
 
 
 o o
 o o o o
 
 
 
 o
 o o o o
 
 
 
 o   o
 o o o o
 
 
 
 o o
 o o o o
 
 
 
 o o o
 o o o o
 
 
 o
 o o
 o o o o
 
 
 o
 o o o
 o o o o
 
 
 o
 o o
 o o o o
 
 
 o
 o o o
 o o o o
 
 
 o o
 o o o
 o o o o
 
 o
 o o
 o o o
 o o o o
 
 There are 14 solutions
 Program ended with exit code: 0 */

/* TEST 2
 Hello! Please enter the number of coins you would like to be on the bottom of the stacked pyramid.
 no
 `no` is not an integer. Please enter an integer
 -0
 `-0` is not greater than 0 or less than 11. Please enter an integer
 0
 `0` is not greater than 0 or less than 11. Please enter an integer
 11
 `11` is not greater than 0 or less than 11. Please enter an integer
 12
 `12` is not greater than 0 or less than 11. Please enter an integer
 45
 `45` is not greater than 0 or less than 11. Please enter an integer
 55%
 `55%` is not an integer. Please enter an integer
 3
 
 
 o o o
 
 
 o
 o o o
 
 
 o
 o o o
 
 
 o o
 o o o
 
 o
 o o
 o o o
 
 There are 5 solutions
 Program ended with exit code: 0 */

/* TEST 3
 Hello! Please enter the number of coins you would like to be on the bottom of the stacked pyramid.
 no
 `no` is not an integer. Please enter an integer
 fine 12
 `fine 12` is not an integer. Please enter an integer
 12
 `12` is not greater than 0 or less than 11. Please enter an integer
 -12
 `-12` is not greater than 0 or less than 11. Please enter an integer
 0
 `0` is not greater than 0 or less than 11. Please enter an integer
 10

 
 
 
 
 
 
 
 
 
 o o o o o o o o o o
 
 
 
 
 
 
 
 
 
 o
 o o o o o o o o o o
 
 
 
 
 
 
 
 
 
 o
 o o o o o o o o o o
 
 
 
 
 
 
 
 
 
 o o
 o o o o o o o o o o
 
 
 .... i can't copy paste this with xcode still working so here's only a portion of it
 
 o
 o o
 o o o
 o o o o
 o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 
 o
 o o
 o o o
 o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 
 o
 o o
 o o o
 o o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 
 o
 o o
 o o o o
 o o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 
 o
 o o o
 o o o o
 o o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 
 o o
 o o o
 o o o o
 o o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 o
 o o
 o o o
 o o o o
 o o o o o
 o o o o o o
 o o o o o o o
 o o o o o o o o
 o o o o o o o o o
 o o o o o o o o o o
 
 16796
 Program ended with exit code: 0 */
