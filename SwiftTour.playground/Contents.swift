//: Playground - noun: a place where people can play

import UIKit


/********** SIMPLE VALUE **********/

/* use \(varName) to include the value of a var in a Str */
var name = "Panpan"
print("Hello \(name)! Welcome to Playground :-)")



/*To create an empty array or dictionary, use the initializer syntax. */
let emptyArray = [String]()
let emptyDictionary = [String: Float]()



/* Optional */
// Optional: value or nil
var optionalString: String? = nil
if let greetingWords = optionalString {
    print("I said \(greetingWords)")
}

// using ?? operator to provide a default value */
let nickName: String? = nil
let defaultName: String = "user"
let informalGreeting = "Hi \(nickName ?? defaultName)!"





/********** CONTROL FLOW **********/

/* Loop */
// In switch case there is no need to use break

// Use for-in to iterate over itmes in a dictionary
for (propertyKeyName, valueName) in emptyDictionary {}

// while loop
while optionalString != nil {}
var myNum = 5
repeat {myNum = myNum-1} while myNum > 1

// index excludes 4
for i in 0..<2 { print ("Counting apple \(i)")}
// index includes 4
for i in 0...2 { print ("Counting pears \(i)")}





/********** FUNCTIONS AND CLOSURES **********/

/* function needs a return type
   argument has: argument label, parameter name, and its type
   default argument label = parameter name
   to omit argument label, use_ 
 */
func greet(_ name: String, on day: String) -> String {
    return "Hello \(name), today is\(day)."
}
greet(name, on: "Friday")


// Use tuple to make a compound value, the element of a tuple can be referred to either by name or by number.
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print (statistics.sum)
print("min is \(statistics.0).")


// functions can also take a variable number of argumnets, in the form of an array
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(numbers: 42, 597, 12)


// Functions are first-class type
// So a function can return another function as its value
func makeIncrementer(incrementBy: Int) -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return incrementBy + number
    }
    return addOne
}
var incrementBy3 = makeIncrementer(incrementBy: 3)
incrementBy3(7)

// and can also take another function as an argument
func hasAnyMathces(list: [Int], condition: (Int)->Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMathces(list: numbers, condition: lessThanTen)


// functions are a special case of closures.
// The code in a closure has access to things that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed.
// You can write a closure without a name by surrounding code with braces ({})
numbers.map({
    // Use 'in' to separate the arguments and return type from the body
    (number: Int) -> Int in
    let result = (number % 2 == 0 ? number : 0)
    return result
})

// when a closure's type is already know, you can omit the type of its paremeter, its return type, or both
numbers.map({
    number in
    return 3 * number
})

// you can refer to parameter by number instead of name
// a closure passed as the last argument to a function can appear immediately after the parenthese
// When a closure is the only argument to a function, you can omit the parentheses entirely
numbers.map{ 2 * $0 }





/********** OBJECTS AND CLASSES **********/
class NamedShape {
    var numberOfSides = 0
    var name: String
    
    // an initializer to set up the class when an instance is created (optional)
    init(name: String){
        // self is used to distinguish the name property from the name argument to the initializer
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = NamedShape(name: "square")
shape.numberOfSides = 4
var shapeDescription = shape.simpleDescription()


// use deinit to create a deinitializer if you need to perform some cleanup before the object is deallocated.


// subclasses include their superclass name after their class name, separated by a colon
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4 // changing the value of properties defined by the superclass
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    // Methods on a subclass that override the superclass's implementation are marked with override
    override func simpleDescription() -> String {
        return "A square with sides of length\(sideLength)."
    }
}


// properties can have a getter and a setter
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3 // changing the value of properties defined by the superclass
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            // in the setter, the new value has the implicit name newValue
            // You can provide an explicit name in parentheses after set.
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)


// use willSet and didSet to run code before and after setting a new value
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "1st triangle and square")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)


// working with Optional, use ? to safely deal with nil
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength










/********** ENUMERATIONS AND STRUCTURES**********/
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
            case .ace:
                return "ace"
            case.jack:
                return "jack"
            case .queen:
                return "queen"
            case.king:
                return "king"
            default:
                // Swift assigns the raw values starting at 0 and incrementing by 1 each time, unless values are specified explicitly, eg. in the case here we start from 1 ('ace').
                return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
let three = Rank.three
let threeRawValue = three.rawValue
let jack = Rank.jack
let jackRawValue = jack.rawValue


// use the init?(rawValue:) initializer to make an instance of an enumeration from a raw value.
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}


// when there isn't a meaningful raw value, you don't have to provide one
enum Suit: Int {
    case spades = 1
    case hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        default:
            return "red"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
hearts.color()


// struct to create structure
// struct gets copied, while classes are passed by reference
struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    func createDeck() -> [Card] {
        var rankNumber = 1
        var deck = [Card]()
        while let rank = Rank(rawValue: rankNumber) {
            var suitNumber = 1
            while let suit = Suit(rawValue: suitNumber) {
                deck.append(Card(rank: rank, suit: suit))
                suitNumber += 1
            }
            rankNumber += 1
        }
        return deck
    }
}


let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

let magicCard = Card(rank: Rank.ace, suit: Suit.clubs)
let deck = magicCard.createDeck()


enum ServerResponse {
    case result(String, String)
    case failure(String)
    case pending(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
let pending = ServerResponse.pending("10:32 am")

switch pending {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
case let .pending(time):
    print("Waiting for response... since \(time)")
}





/********** PROTOCOLS & EXTENSIONS **********/
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}


// Classes, enum, and structs can all adopt protocols
class SimpleClass: ExampleProtocol {
    internal var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    // method on a class can always modify a class so the mutation keyword is not needed
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
print(a.anotherProperty)


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


// this is not a good solution
enum SimpleEnum1: ExampleProtocol {
    case Base, Adjusted
    
    var simpleDescription: String {
        return self.getDescription(message: "A simple enumeration")
    }
    
    func getDescription(message: String) -> String {
        return message
    }
    
    mutating func adjust() {
        switch self {
        case .Base:
            self.simpleDescription
        case .Adjusted:
            self.getDescription(message: self.simpleDescription + "but adjusted.")
        }
    }
}


// this is a much better solution
enum SimpleEnum2: ExampleProtocol {
    case Base, Adjusted
    
    var simpleDescription: String {
        get {
            return getDescription()
        }
    }
    
    func getDescription() -> String {
        switch self {
            case .Base:
            return "A simple enum"
            case .Adjusted:
            return "A simple enum [adjusted!]"
        }
    }
    
    mutating func adjust() {
        self = .Adjusted
    }
}
var simpleEnum2 = SimpleEnum2.Base
simpleEnum2.simpleDescription
simpleEnum2.adjust()
simpleEnum2.simpleDescription


// use extension to add functionality to an existing type
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)


extension Double {
    var absoluteValue: Double {
        return abs(self)
    }
}
print((-3.5).absoluteValue)


// use protocol name just like any other named type
// you can create a collection of objects that have different types but that all conform to a single protocol
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// when you work with values whose type is a protocol type, methods outside the protocol definition are not availble! The following will fail:
//print(protocolValue.anotherProperty)

// this one is not treated as type ExampleProtocol, but instead as SimpleClass, so anotherProperty is accessible
let anotherProtocolValue = a
anotherProtocolValue.anotherProperty





/********** Error Handling **********/
// represent errors using any type that adopts the Error protocol
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

enum UnknownError: Error {
    case unknownError
}


// use throw to throw an error and throws to mark a function that can throw an error
// if you throw an error in a function, the function returns immediately
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    if printerName == "Overheated" {
        throw PrinterError.onFire
    }
    if printerName == "Never Has Paper" {
        throw PrinterError.outOfPaper
    }
    if printerName == "Schrodinger's Cat" {
        throw UnknownError.unknownError
    }
    return "Job sent"
}


// mark code that can throw an error by writing 'try' in front of it
do {
    let printerResponse = try send(job: 5, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    // in the 'catch' block, the error is automatically given the name 'error' unless you give it a different name
    print(error)
}

do {
    let printerResponse = try send(job: 400, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

// multiple catch blokcs that handle erros differently
do {
    let printerReponse = try send(job: 404, toPrinter: "Schrodinger's Cat")
    print(printerReponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}


// use try? to convert the result to an optional
// if the function throws an error, the specific error is discarded and the result is nil; otherwise the result is an optional
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")


// use defer to write a block of code that is executed after all other code in the function, just before the function returns
// executed either the function throws an error or not
// good for writing setup and cleanup nocde, alongside each other
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("banana")
print(fridgeIsOpen)





/********** GENERICS **********/
// write a name inside angle brackets to make a generic function or type
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes:4)


// you can make generic functions / methods / classes / enums / structures
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)


// where: to specify a list of requirements
func anyCommonElements<T: Sequence, U:Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}
anyCommonElements([1, 2, 3], [3])


// <T: Equatable> is the same as: <T> ... where T: Equatable
func returnCommonElements<T: Sequence, U:Sequence>(_ lhs: T, _ rhs: U) -> [AnyObject]
where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
    var commonElements = [AnyObject]()
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                commonElements.append(lhsItem as AnyObject)
            }
        }
    }
    return commonElements
}
returnCommonElements([1, 2, 3, 4, 5], [1, 3, 5, 7])

