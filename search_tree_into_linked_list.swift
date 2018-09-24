//
//  A. Achimescu
//  assign_2_9_searchTreeIntoLinkedList.playground
//
//
//  This program will input the values in a tree into a linked list, given boundaries by the user
//

import Foundation

// only give restrictions when the user first says how long they want their tree array to be!
// then, it will become true and the int inputted will no longer HAVE to be greater than 0
var input:Bool = false

// binary search tree class, defines important functions / variables used later on
class BinarySearchTree <T:Comparable> {
    var value: T
    var parent: BinarySearchTree?
    var left: BinarySearchTree?
    var right: BinarySearchTree?
    
    // value in array
    init(value: T) {
        self.value = value
    }
    
    // input a value into the tree
    func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    // used so then this class can recieve integers
    convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    // this function searches through the entire tree to try to find a certain value
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self  // found it!
        }
    }
    
    // this will insert the tree into a string and print the string if called
    var printTree: String {
        var s = ""
        if let left = left {
            s += "(\(left.printTree)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.printTree))"
        }
        return s
    }
}

// a node
class node {
    var value: Int? = nil
    var next: node? = nil
}

// the linked list !!
class linkedList {
    var head:node?
    var current:node?
    
    // this function inserts new integers into the linked list
    func insert(_ value: Int) {
        // is this an empty list
        if self.head == nil { // empty list
            self.head = node()
            self.head!.value = value
            self.current = self.head
        } else {
            let newNode = node()
            newNode.next = self.current?.next
            self.current?.next = newNode
            newNode.value = value
            self.current = newNode
        }
    }
    
    // this function print out all the current items in the linked list
    func printAllKeys() {
        var tempNode:node? = self.head
        
        while tempNode != nil && tempNode!.value != nil {
            print(tempNode!.value!)
            tempNode = tempNode!.next
        }
    }
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
            if unwrappedInt > 0 || input == true {
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

// ask user for the length of tree array
print("Hello! How many numbers would you like to be inside your tree?")
var num:Int = getInteger()

// ask user if they want to fill up the tree
print("If you want to fill up the tree yourself, please enter 0.")
print("Otherwise, please hit any key.")
var random:String = readLine()!     // get a random key from the user
var numInsert:Int = 0               // the number inserted into the tree array
var check:Bool = false              // in order to check for duplicates
var searchtreeArray:[Int] = []      // array used to check whether numInsert has already been entered before
var checkIfEmpty:Bool = false       // check to see if theres anything in linked list

// ask the user to fill up the tree
if random == "0" {
    print("Please insert", num, "numbers with enters in between")
    
    for _ in 1...num {
        repeat {
            input = true
            numInsert = getInteger()
            
            // check to see if the number has already been inputted before
            for i in 0..<searchtreeArray.count {
                if numInsert == searchtreeArray[i] {
                    print("Sorry, that number has already been inputted. Please input a new number.")
                    check = true
                    break
                }
                    // if the check remains to be false, then it can exit the loop
                else {
                    check = false
                }
            }
        } while check == true
        
        searchtreeArray.append(numInsert)
    }
}
    // randomly insert integers into array
else {
    for _ in 1...num {
        numInsert = Int(arc4random_uniform(100))
        searchtreeArray.append(numInsert)
    }
}

// declare new tree with the array given / randomly chosen
let binarySearchTree = BinarySearchTree<Int>(array: searchtreeArray)

// print out tree for reference
print("This is your tree:")
print(binarySearchTree.printTree)

// ask user for 2 boundaries
print("Please input two numbers with enters in between. They will be used as the linked list's boundaries")
input = true                        // in order for negative numbers to be accepted as well
var boundary1:Int = getInteger()
var boundary2:Int = getInteger()

// declare new linked list
var myList = linkedList()

// check to make sure that first boundary is LESS than, otherwise change up the two
var holdValue = boundary1
if boundary1 > boundary2 {
    boundary1 = boundary2
    boundary2 = holdValue
}

// input all values inbetween the given boundaries by the user
for i in (boundary1 + 1)...(boundary2 - 1) {
    if binarySearchTree.search(value: i) != nil {
        myList.insert(i)
        checkIfEmpty = false
    }
}

// print out linked list
print("")
if checkIfEmpty == true {
    print("There is nothing in your linked list")
}
else {
    // print the new linked list
    print("These are the elements in your new linked list:")
    myList.printAllKeys()
}

/* TEST 1
 Hello! How many numbers would you like to be inside your tree?
 5
 If you want to fill up the tree yourself, please enter 0.
 Otherwise, please hit any key.
 
 This is your tree:
 ((21) <- 33 -> ((46) <- 59)) <- 87
 Please input two numbers with enters in between. They will be used as the linked list's boundaries
 23
 60
 
 These are the elements in your new linked list:
 33
 46
 59
 Program ended with exit code: 0 */

/* TEST 2
 Hello! How many numbers would you like to be inside your tree?
 -9
 `-9` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 5
 If you want to fill up the tree yourself, please enter 0.
 Otherwise, please hit any key.
 -9
 This is your tree:
 ((47) <- 48 -> (61)) <- 63 -> (92)
 Please input two numbers with enters in between. They will be used as the linked list's boundaries
 -9
 65
 
 These are the elements in your new linked list:
 47
 48
 61
 63
 Program ended with exit code: 0
 */

/* TEST 3
 Hello! How many numbers would you like to be inside your tree?
 10
 If you want to fill up the tree yourself, please enter 0.
 Otherwise, please hit any key.
 
 This is your tree:
 (11 -> (14 -> (29))) <- 31 -> (39 -> (((72) <- 86) <- 91 -> (92 -> (92))))
 Please input two numbers with enters in between. They will be used as the linked list's boundaries
 86
 -6
 
 These are the elements in your new linked list:
 11
 14
 29
 31
 39
 72
 Program ended with exit code: 0 */

/* TEST 4
 Hello! How many numbers would you like to be inside your tree?
 15
 If you want to fill up the tree yourself, please enter 0.
 Otherwise, please hit any key.
 0
 Please insert 15 numbers with enters in between
 45
 -9
 34
 no
 `no` is not an integer. Please enter an integer
 34
 Sorry, that number has already been inputted. Please input a new number.
 23
 12
 45
 Sorry, that number has already been inputted. Please input a new number.
 no
 `no` is not an integer. Please enter an integer
 0
 8
 5
 4
 87
 6
 5
 Sorry, that number has already been inputted. Please input a new number.
 0
 Sorry, that number has already been inputted. Please input a new number.
 45
 Sorry, that number has already been inputted. Please input a new number.
 5
 6Sorry, that number has already been inputted. Please input a new number.
 6
 5
 Sorry, that number has already been inputted. Please input a new number.
 67
 87
 Sorry, that number has already been inputted. Please input a new number.
 54
 36
 This is your tree:
 (-9 -> ((((0 -> (((4) <- 5 -> (6)) <- 8)) <- 12) <- 23) <- 34 -> (36))) <- 45 -> (((54) <- 66 -> (67)) <- 87)
 Please input two numbers with enters in between. They will be used as the linked list's boundaries
 34
 0
 
 These are the elements in your new linked list:
 4
 5
 6
 8
 12
 23
 Program ended with exit code: 0 */

/* TEST 5
 Hello! How many numbers would you like to be inside your tree?
 11
 If you want to fill up the tree yourself, please enter 0.
 Otherwise, please hit any key.
 0
 Please insert 11 numbers with enters in between
 4
 2
 8
 1
 3
 6
 10
 5
 7
 9
 11
 This is your tree:
 ((1) <- 2 -> (3)) <- 4 -> (((5) <- 6 -> (7)) <- 8 -> ((9) <- 10 -> (11)))
 Please input two numbers with enters in between. They will be used as the linked list's boundaries
 2
 8
 
 These are the elements in your new linked list:
 3
 4
 5
 6
 7
 Hello, World!
 Program ended with exit code: 0 */
