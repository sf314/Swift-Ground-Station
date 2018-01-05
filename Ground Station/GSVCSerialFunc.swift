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

// MARK: - Port Selection UI item
extension GSViewController {
    func setupPortSelector() {
        print("Setting up port selector")
        
        // Binding
        portSelector.bind(.content, to: serialPortManager, withKeyPath: "availablePorts", options: nil) // Works
        portSelector.bind(.contentValues, to: serialPortManager, withKeyPath: "availablePorts.name", options: nil)
        //portSelector.bind(.selectedValue, to: port, withKeyPath: "self", options: nil)
        // ^^ serialPort, "self": Causes exception upon selection, for key "self"
        // ^^ self, "serialPort": not kvc compliant for key "serialPort"
        // ^^ port, "self": Causes exception upon selection, for key "self"
        // ^^ Ignore this line for now...?
        
        // Styling
        portSelector.setTitle("Port Selector")
        portSelector.bezelStyle = .roundRect
        portSelector.frame.size.width = 300.0 // Changeable
        portSelector.frame.size.height = 30.0 // Does not visually change
        portSelector.frame.origin = CGPoint(x: 50, y: 50)
        portSelector.bezelStyle = .rounded // THIS IS THE ONE
        view.addSubview(portSelector)
    }
}

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
            print("Received: \(string)") // 16 characters at a time, MS \r\n ending
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
    }
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("Serial port was closed")
    }
    
    // Open or close the port
    @IBAction func buttonPressed(_ sender: NSButton) { // Use @Objc or @IBAction
        print("Button pressed! It was called " + sender.title)
        if self.port == nil {
            let stringPath = "/dev/cu." + portSelector.selectedItem!.title // HOLY COW FULL PATH
            print("buttonPressed: stringPath = \(stringPath)")
            port = ORSSerialPort(path: stringPath)
        }
        if let port = self.port {
            if port.isOpen {
                port.close() // Never run?
                sender.title = "Open"
                print("buttonPressed: Closed port")
            } else {
                port.open() // If error, need USB access entitlement (for sandbox)
                port.delegate = self // BLOODY HELL
                port.baudRate = 9600
                sender.title = "Close"
                print("buttonPressed: Opened port. Is it really open? \(port.isOpen)")
            }
        } else { 
            print("buttonPressed: Port was null.") 
        }
        print("buttonPressed: Current port baud is: \(String(describing: port?.baudRate))")
        print("buttonPressed: Selected item is: \(String(describing: portSelector.selectedItem?.title))")
    }
}
