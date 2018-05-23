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
 
 Maybe parse one character at a time like CSGps?
 */

class TelemParser {
    // Init?
    init() {
        tempString = ""
        stringQueue = []
    }
    
    // Vars
    var tempString: String
    var stringQueue: [String]
    let expectedPacketSize = 17
    let expectedPacketHeader = "5324"
    
    // Funcs
    func ingest(_ c: Character) {
        if (c == "\r\n") {
            stringQueue.append(tempString)
            tempString = ""
            return
        }
        if (c == "\r") {
            print("TelemParser.ingest(): Warning! Lonely \n or \r detected! Will still append current string, tho. ")
            stringQueue.append(tempString)
            tempString = ""
            return
        }
        if (c == "\n") {
            print("Warnin")
            return
        }
        
        tempString.append(c)
    }
    
    func isValid(_ packet: String) -> Bool {
        // Split it into segments by comma
        // Check length. Should be expectedPacketSize
        let arr = packet.split(separator: ",")
        if arr.count == expectedPacketSize {
            if arr[0] == expectedPacketHeader {
                return true
            }
            return false
        }
        return false
    }
    
    func hasPackets() -> Bool {
        return stringQueue.count > 0
    }
    
    func popNext() -> String {
        return stringQueue.remove(at: 0)
    }
}


/*** For testing
 Exclude the line ending!
 */
func fakePacket() -> String {
    var returnString = "5324" + ","
    for i in 0..<16 {
        returnString += String(arc4random() % 100)
        if i != 15 {
            returnString += ","
        } 
    }
    return returnString
}
