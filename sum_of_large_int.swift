//
//  assign_1_5_sumOfLargeInt.playground
//  A. Achimescu
//
//  This program find the sum of a potentially large integer's digits

import Foundation

// get string int from user
print("Hi! Please enter a very large integer!")

// Declare the variables
var digits:[Int] = []           // Array that will be full of integers inputed by the user
var sumOfDigits = 0             // Sum of the digits in array
var check = 0                   // Variable used in the while loop

// Checking whether the value obtained from the user is a positive integer
while check == 0 {
    // Take in a string from the user
    let response:String = readLine()!
    digits = []
    
    // Add the characters from the string into an array of integers
    for i in response {
        let someString = String(i)
        
        // If the character in the string is of an integer value, add into the array of integers
        if let someInt = Int(someString) {
            digits.append(someInt)
            check = 1   // needed to exit the while loop
        }
        else {
            print("The value inputted is not a postive integer. Please enter a positive integer.")
            check = 0   // in order to restart the while loop
            break       // exit the for loop and ask the user for another integer
        }
    }
}
print("The value inputted was a number! Thank you!") // confirm the value inputted is a number

// the number of digits in the large integer, which is really just an array
let numOfDigits:Int = digits.count

// for loop that adds up all the digits in the large int
for i in 0...(numOfDigits-1) {
    sumOfDigits = sumOfDigits + digits[i] // find the sum of all digits
}

// Print out the sum of the digits in the large int
print("The sum of the digits in your large integer is:", sumOfDigits)
    
/* TEST 1
 Hi! Please enter a very large integer!
 i dont wanna give you an int :(
 The value inputted is not a postive integer. Please enter a positive integer.
 oh sorry what about -0?
 The value inputted is not a postive integer. Please enter a positive integer.
 i see okay 5
 The value inputted is not a postive integer. Please enter a positive integer.
 fine 5
 The value inputted is not a postive integer. Please enter a positive integer.
 -5
 The value inputted is not a postive integer. Please enter a positive integer.
 *5*
 The value inputted is not a postive integer. Please enter a positive integer.
 847543853885935820582
 The value inputted was a number! Thank you!
 The sum of the digits in your large integer is: 110
 Program ended with exit code: 0*/

/* TEST 2
 Hi! Please enter a very large integer!
 0
 The value inputted was a number! Thank you!
 The sum of the digits in your large integer is: 0
 Program ended with exit code: 0 */

/* TEST 3
 Hi! Please enter a very large integer!
 45353454-
 The value inputted is not a postive integer. Please enter a positive integer. 345734549852584235843598320458423095894308504398509432850923485923485409238540492385984320958034958093485093829289384598432958439589034285094835094382509285049238508324095803498509348509348509238450396768594038454687493024576839208475678392038947568392038457678493204756783920475674839248576748935767489302756849374658
 The value inputted was a number! Thank you!
 The sum of the digits in your large integer is: 1592
 Program ended with exit code: 0 */




