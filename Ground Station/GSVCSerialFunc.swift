//
//  GSVCSerialFuncs.swift
//  Ground Station
//
//  Created by Stephen Flores on 1/4/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//
/*
 This file defines functionality related to ORSSerialPort, including bindings.
 They will be encapsulated in separate extension statements for clarity.
 Note, you will need to allow USB access:
    Project -> Capabilities -> App Sandbox -> Hardware -> USB (checkbox)
    Wait, missing now???
 */
import Foundation
import AppKit
import Cocoa


// MARK: - Protocol Compliance
extension GSViewController {
    // Required
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        print("Port was removed from system!")
        self.port = nil
    }
    
    // Receive data at port
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            let s = string as String
            print("Received: \(s)") // 16 characters at a time, MS \r\n ending
            addToSerialMonitor(s) // Handles parsing
            
        } else {
            print("Bad data at port.")
        }
    }
    
    // Handle error detect 
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
    
    // Notify open and close
    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        print("Serial port was opened")
        connectButton.title = "Disconnect"
    }
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("Serial port was closed")
        connectButton.title = "Connect"
    }
    
    // Open or close the port
    @IBAction func connect(_ sender: NSButton) { // Use @Objc or @IBAction
        // Check state of port for safety!!!
        print("Button pressed! It was called " + sender.title)
        if self.port == nil {
            let stringPath = "/dev/cu." + portSelector.selectedItem!.title // HOLY COW FULL PATH
            print("connectButton: stringPath = \(stringPath)")
            port = ORSSerialPort(path: stringPath)
        }
        if let port = self.port {
            if port.isOpen {
                port.close() // Never run?
                sender.title = "Connect"
                print("connectButton: Closed port")
            } else {
                port.open() // If error, need USB access entitlement (for sandbox)
                port.delegate = self // BLOODY HELL
                port.baudRate = 9600
                sender.title = "Disconnect"
                print("connectButton: Opened port. Is it really open? \(port.isOpen)")
            }
        } else { 
            print("connectButton: Port was null.") 
        }
        print("connectButton: Current port baud is: \(String(describing: port?.baudRate))")
        print("connectButton: Selected item is: \(String(describing: portSelector.selectedItem?.title))")
    }
}
