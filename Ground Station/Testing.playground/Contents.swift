//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

// Test parsing strings (of zeroes and ones, initially!)
print("Hey")
// Class Definition
class Parser {
    
    // Data Variables
    var readyQueue: [String] = []
    var tempString = ""
    var delimiter = "12"
    
    // Primary functions
    func add(_ s: String) {
        // Break into units based on delimiter
        // Go thru components and put strings in ready queue (use tempstring)
        // If no delimiter, then simple append and return. Else:
        // For each component starting at top:
            // Add to tempString. // Even blank!
            // If has more elements after it, then add to queue/clear 
        
        print("Parser: adding \(s)")
        var components = s.components(separatedBy: delimiter)
        print("    Units: \(components)")
        
        // If very first is empty, then push current tempstring
        if components[0] == "" {
            readyQueue.append(tempString)
            tempString = ""
            components.remove(at: 0)
        }
        
        while components.count > 0 {
            // Edge case
            if components[0] == "" {
                components.remove(at: 0)
                continue
            }
            
            // Main logic
            if components.count == 1 {
                // Just append
                tempString += components[0]
                components.remove(at: 0) // pop
            } else {
                // Append and queue
                tempString += components[0]
                components.remove(at: 0)
                readyQueue.append(tempString)
                tempString = ""
            }
        }
        
    }
    
    func hasLine() -> Bool {
        // Final check: Make sure empty string does not go thru
        if readyQueue.count != 0 {
            if readyQueue[0] == "" {
                readyQueue.remove(at: 0)
                return false 
            }
            return true
        } else {
            return false
        }
    }
    
    func getNextLine() -> String {
        return readyQueue.remove(at: 0)
    }
    
    // Helper functions
}


// ***** Tests
let parser = Parser()

// Test hasLine(), getNextLine
parser.readyQueue.append("abcd")
parser.readyQueue.append("efgh")
parser.readyQueue.append("ijkl")
while parser.hasLine() {
    print("Received \(parser.getNextLine())")
}

// Test add()
// 00001000 00000100 00010001 00000010 00001001 00000100 000100100
// If one:
    // append
// If two:
    // append and queue first, append second
    // Works even if either is emptyString
// General:
    // Append and return all but the last one, which is just an append
let testStrings = [
    "abcdefghzzzzzz",
    "ijklzzzzz12abc", // l
    "dezzzz12ab12ab", // e, b, b
    "1abcdefgzzzzzz", 
    "hijklmnzzzzzz1", // n
    "2abcdzzzz12abc", // d, c
    "12abzzz12a12ab", // b, a 
    "cdzzzz12ab12a1", // d, b, a // Case: newline @ end followed by newline @ beginning
    "212a121212ab12", // a, b
    "azzzz12abcde12" // a e
]

var returnedStrings: [String] = []
print("Iterating over all test strings")
for s in testStrings {
    parser.add(s)
    while parser.hasLine() {
        returnedStrings.append(parser.getNextLine())
    }
}

print("\n\nPrinting results")
for s in returnedStrings {
    print(s)
}
