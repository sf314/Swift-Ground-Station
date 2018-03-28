//
//  Parser.swift
//  Ground Station
//
//  Created by Stephen Flores on 3/14/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import Foundation

/* ***** Parser
 Purpose: To accept an indefinite set of strings and return complete lines
 
 Interface:
 add(input: String)
 hasLine() -> Bool
 
 */

class Parser {
    
    // Init
    init() {
        delimiter = "\r\n"
    }
    
    init(delimiter d: String) {
        delimiter = d
    }
    
    // Data Variables
    var readyQueue: [String] = []
    var tempString = ""
    var delimiter = "\n"
    
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
