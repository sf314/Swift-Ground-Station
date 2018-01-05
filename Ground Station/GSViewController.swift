//
//  GSViewController.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/10/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import AppKit

import Cocoa

class GSViewController: NSViewController, ORSSerialPortDelegate {
    
    
    // MARK: - Data Variables
    
    // MARK: - Serial Port
    let serialPortManager = ORSSerialPortManager.shared()
    var port: ORSSerialPort? {
        didSet { // Is this necessary?
            oldValue?.close()
            oldValue?.delegate = nil
            port?.delegate = nil
            print("Port: Triggered didSet")
            print("Port: name is \(port?.path ?? "NONE")")
        }
    }
    
    
    let portSelector = NSPopUpButton()
    
    override func viewDidAppear() {
        super.viewDidAppear()
        print("View did appear")
        
        // Draw UI here
        let button = NSButton(title: "Connect", target: self, action: #selector(self.buttonPressed))
        button.setButtonType(.momentaryPushIn)
        button.bezelStyle = .rounded
        view.addSubview(button)
        
        setupPortSelector()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
        
        print("\(view.frame.size.width) by \(view.frame.size.height)")
        print(portSelector.frame.size.width)
    }
    
}
