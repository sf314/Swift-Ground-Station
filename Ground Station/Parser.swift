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

let packetLength = 17

class TelemParser {
    // Init?
    init() {
        tempString = ""
        stringQueue = []
    }
    
    // Vars
    var tempString: String
    var stringQueue: [String]
    let expectedPacketSize = packetLength
    let peanutPacketHeader = "5324"
    let butterPacketHeader = "5278"
    let expectedPacketHeader = "5324" // Or the other one
    
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
            if arr[0] == butterPacketHeader || arr[0] == peanutPacketHeader {
                return true
            }
            return false
        }
        print("Invalid packet. Got size of \(arr.count), expected \(expectedPacketSize)");
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
    
    returnString += String(arc4random() % 100) + "," //    var met = 0.0
    returnString += String((arc4random() % 100)) + "," //    var packetCount = 0
    returnString += String(Double(arc4random() % 100)) + "," //    var altitude = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var pressure = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var temp = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var volt = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var gps_time = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var gps_lat = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var gps_lon = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var gps_alt = 0.0
    returnString += String((arc4random() % 100)) + "," //    var gps_sats = 0
    returnString += String(Double(arc4random() % 100)) + "," //    var tilt_x = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var tilt_y = 0.0
    returnString += String(Double(arc4random() % 100)) + "," //    var tilt_z = 0.0
    returnString += String((arc4random() % 100)) + "," //    var state = 0
    returnString += String(Double(arc4random() % 100))//    var volt2 = 0.0
    
    return returnString
}


/*
 Example frames:
 1234,122,122,9842.06,-51040.00,234.88,-0.32,0,0.00,0.00,0.00,0,0.00,0.00,165.18,5,1.98
 */
