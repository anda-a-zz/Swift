//
//  assign_1_9_harmonicSeries.playground
//
//  A. Achimescu
//
//  This program will write out the harmonic series as a fraction for any given integer
//  The harmonic series is 1 + 1/2 + 1/3 + ... + 1/n 

import Foundation

func printFactorial(_ number:Int) {
    //array will have the capacity to store 2^n digits.
    var factorialDigits:[Int] = []
    
    // input 0s into array so swift can have a value for all elements in array
    for _ in 0...number {
        for _ in 0...2 {
            factorialDigits.append(0)
        }
    }
    
    var carryingValue:Int = 0       // Initializes carry variable to 0.
    var digitCounter:Int = 1        // initializes digit counter
    var digitProd:Int = 0           // contains the digit by digit product

    factorialDigits[0] = 1          // makes the first digit in the array be one
    
    for i in 1...number {
        for j in 0..<digitCounter {
            digitProd = factorialDigits[j]*i + carryingValue    // contains the digit by digit product
            factorialDigits[j] = digitProd % 10                 // contains the digit to store in position j (from the for loop)
            carryingValue = digitProd / 10                      // contains the carry value that will be stored on later indexes
        }
        //while loop that will store the carry value on array.
        while carryingValue > 0 {
            factorialDigits[digitCounter] = carryingValue % 10
            carryingValue = carryingValue / 10
            digitCounter += 1 // increments digit counter
        }
    }
    
    
    //printing the factorial of the n given integer
    for i in stride(from: (digitCounter - 1), to: -1, by: -1) {
        print(factorialDigits[i], terminator:"")
    }
    // print a new line
    print("")
}

func printFactorialThenDivide (_ number:Int, _ divisor:Int) -> Array<Int> {
    //array will have the capacity to store 2^n digits.
    var factDivided:[Int] = []

    // input 0s into array so swift can have a value for all elements in array
    for _ in 0...number {
        for _ in 0...2 {
            factDivided.append(0)
        }
    }
    
    var carryingValue:Int = 0        // initializes carry variable to 0.
    var digitCounter:Int = 1         // initializes digit counter
    var digitProd:Int = 0            // contains the digit by digit product
    
    
    // calculate with integer array but use input and return as int array
    
    factDivided[0] = 1        //initializes array with only 1 digit, the digit 1.
    
    // find the digits in the factDivided array (factorial of number / divisor)
    for i in 1...number {
        for j in 0..<digitCounter {
            // multiply the numbers together in the factorial, but leave out the divisor in this multiplication process
            if i != divisor {
                digitProd = factDivided[j]*i + carryingValue         // contains the digit by digit product
                factDivided[j] = digitProd % 10                      // contains the digit to store in position j (from the for loop)
                carryingValue = digitProd / 10                       // contains the carry value that will be stored on later indexes
            }
        }
        //while loop that will store the carry value on array.
        while carryingValue > 0 {
            factDivided[digitCounter] = carryingValue % 10
            carryingValue = carryingValue / 10
            digitCounter += 1 // increments digit counter
        }
    }
    
    // return the new array without any zeros
    var factDividedClean:[Int] = []
    
    // copy the first array into the second (clean) array
    for i in 0...(digitCounter-1) {
        factDividedClean.append(factDivided[i])
    }
    
    return factDividedClean
}

// input original 2 arrays to be added, but in order to be able to change the arrays, copy them into another 2 arrays and return the new 2 arrays
// this func finds the sum of 2 arrays
func sumOfArrays(_ firstArrayOG:[Int], _ secondArryOG:[Int]) -> Array<Int> {
    // make a copy of the first array
    var lengthOfFirst:Int = firstArrayOG.count
    var firstArrayCopy:[Int] = firstArrayOG
    
    for _ in 0...lengthOfFirst {
        firstArrayCopy.append(0)
    }
    
    // make a copy of the second array
    let lengthOfSecond:Int = secondArryOG.count
    var secondArrayCopy:[Int] = secondArryOG
    
    for _ in 0...lengthOfSecond {
        secondArrayCopy.append(0)
    }
    
    // make the array that will store the sum of the 2 digits (make it extra long jic)
    var sumOfTwoArrays = Array(repeating: 0, count:(lengthOfFirst + lengthOfSecond))
    
    var digitProd:Int = 0                   // contains the digit by digit product
    var carryingValue:Int = 0               // initializes carry variable to 0

    for i in 0..<lengthOfFirst {
        digitProd = firstArrayCopy[i] + secondArrayCopy[i] + carryingValue      // contains the digit by digit product
        sumOfTwoArrays[i] = digitProd % 10                                      // contains the digit to store in position i
        carryingValue = digitProd / 10                                          // contains the carry value that will be stored on later indexes
    }
    if carryingValue != 0 {
        sumOfTwoArrays[lengthOfFirst] = 1
        lengthOfFirst += 1                  // To make the new array longer
    }
    
    // to return the sum array without any zeros
    var sumOfTwoArraysClean:[Int] = []
    
    for i in 0...(lengthOfFirst-1) {
        sumOfTwoArraysClean.append(sumOfTwoArrays[i])
    }

    // remember to print this backwards!
    return sumOfTwoArraysClean
}

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
            // Only use the value inputted by the user if it's over 0
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

// ask the user for an integer
print("Hi! Please enter an integer greater than 0!")
var number:Int = getInteger()

// initialize a sum array to insert the value returned from the functions used
var sumOfFactDivide:[Int] = []

// if the number is less than 2, then that means its 1 and the harmonic series of 1 is just 1
if number < 2 {
    sumOfFactDivide[0] = number
}
// if the number is 2, then it will not work in the for loop in the other else, so we must calculate the sum seperately
else if number == 2 {
    sumOfFactDivide = sumOfArrays([2], [1])
}
else {
    sumOfFactDivide = sumOfArrays(printFactorialThenDivide(number, 1), printFactorialThenDivide(number, 2));
    
    for i in 3...number {
        sumOfFactDivide = sumOfArrays(sumOfFactDivide, printFactorialThenDivide(number, i));
    }
}


print("The harmonic series of 1 + ... 1/\(number) is (\(number)!/1 + ... \(number)!/\(number)) / \(number)!")
print("The fraction of this sum would be:")

for i in stride(from: (sumOfFactDivide.count-1), to: -1, by: -1) {
    print(sumOfFactDivide[i], terminator:"")
}


print(" / ", terminator:"")
printFactorial(number)


/* TEST 1
 Hi! Please enter an integer greater than 0!
 1000
 The harmonic series of 1 + ... 1/1000 is (1000! / 1 + ... 1000!/1000) / 1000!
 The fraction of this sum would be: 3012058109963778576850047353091030345834088800484864256109727300619619720457743192724843502600015772437280551851995697594084125148191731814727240445275701258348052073021341696983234785686190214297853391905057921349046912063241376337707003899319016581698412065166289044929641389104681859072317146368702474693242096620558577725123928517944300952601982630690174263191504721907677376944158119844319138709416642818514500984295606892920647541040534256363010895377518912068678759240313142181962514862304956303089263555290591218818689888076751590196315416315713410648302745264398274213095677466492968908814469744050286347298060994670549411051971357138630331126733333378199589251179075640016819901691399870633816600500672028159825181391109218828131231966847107041139074981366419074671285294773655483149857366691645166092403661437022736121345961986420543938679327572048971557116959513554574648448285537222663230284379443493151186217936662382576758815299458421747930368185909752201815576995044056267370908038343087862860967164995151343376347337548856845433606762612704476792603707336956577709133259788584562473115526033206351144213204351751167325161766668133438096341655499355336851878755767770359142846564537046871979685927099352050631629090842023493058775540011583180537328514655540994905261057880051707532216063042823514374448880783420791359735443771878856912700616694975439317912639846981948571443560857643195362436126400289478773475323546860934211184628821696825959075880453315725564991339198854921387005748247624297195687797365286940201399417211610022133411765773712584194671082782679750342830798412465420840278400097520460476377458499672218406306610858179225091926911895976474434742782263545584220467061205299814931219337147915391456240433307964929643234988267468956999547330806188598925884165947477645290979466170469945207092597322317924130658770486604731703484231004761937818196603142458375774542117813127437671821885604686864043411871879650562801539351887731185220967802238173383319922619064129333784014349873994372508051521318368706998600961939551226837874648939135738852064756466328229671983336293152541277362944030693577165074299468990299256980499339537254181495910926061693244925763907469892707211648290900573191110584552241284503666264494191862717796302056576767672199317187132121620093009827702987148231200863631389491200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 / 402387260077093773543702433923003985719374864210714632543799910429938512398629020592044208486969404800479988610197196058631666872994808558901323829669944590997424504087073759918823627727188732519779505950995276120874975462497043601418278094646496291056393887437886487337119181045825783647849977012476632889835955735432513185323958463075557409114262417474349347553428646576611667797396668820291207379143853719588249808126867838374559731746136085379534524221586593201928090878297308431392844403281231558611036976801357304216168747609675871348312025478589320767169132448426236131412508780208000261683151027341827977704784635868170164365024153691398281264810213092761244896359928705114964975419909342221566832572080821333186116811553615836546984046708975602900950537616475847728421889679646244945160765353408198901385442487984959953319101723355556602139450399736280750137837615307127761926849034352625200015888535147331611702103968175921510907788019393178114194545257223865541461062892187960223838971476088506276862967146674697562911234082439208160153780889893964518263243671616762179168909779911903754031274622289988005195444414282012187361745992642956581746628302955570299024324153181617210465832036786906117260158783520751516284225540265170483304226143974286933061690897968482590125458327168226458066526769958652682272807075781391858178889652208164348344825993266043367660176999612831860788386150279465955131156552036093988180612138558600301435694527224206344631797460594682573103790084024432438465657245014402821885252470935190620929023136493273497565513958720559654228749774011413346962715422845862377387538230483865688976461927383814900140767310446640259899490222221765904339901886018566526485061799702356193897017860040811889729918311021171229845901641921068884387121855646124960798722908519296819372388642614839657382291123125024186649353143970137428531926649875337218940694281434118520158014123344828015051399694290153483077644569099073152433278288269864602789864321139083506217095002597389863554277196742822248757586765752344220207573630569498825087968928162753848863396909959826280956121450994871701244516461260379029309120889086942028510640182154399457156805941872748998094254742173582401063677404595741785160829230135358081840096996372524230560855903700624271243416909004153690105933983835777939410970027753472000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
 Program ended with exit code: 0 */

/* TEST 2
 Hi! Please enter an integer greater than 0!
 -8
 `-8` is not greater than 0. Please enter an integer
 0
 `0` is not greater than 0. Please enter an integer
 2
 The harmonic series of 1 + ... 1/2 is (2!/1 + ... 2!/2) / 2!
 The fraction of this sum would be:
 3 / 2
 Program ended with exit code: 0 */

/* TEST 3
 Hi! Please enter an integer greater than 0!
 ((()9
 `((()9` is not an integer. Please enter an integer
 0008
 The harmonic series of 1 + ... 1/8 is (8!/1 + ... 8!/8) / 8!
 The fraction of this sum would be:
 109584 / 40320
 Program ended with exit code: 0 */

