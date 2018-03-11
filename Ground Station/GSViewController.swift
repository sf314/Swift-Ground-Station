//
//  GSViewController.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/10/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics
import Cocoa

class GSViewController: NSViewController, NSWindowDelegate, NSToolbarDelegate, ORSSerialPortDelegate {
    
    // MARK: - Data Variables
    
    // MARK: - Serial Port
    let serialPortManager = ORSSerialPortManager.shared()
    var port: ORSSerialPort? {
        didSet { // Is this necessary?
            oldValue?.close()
            oldValue?.delegate = nil
            port?.delegate = nil
            print("Port: didSet")
            print("Port: name is \(port?.path ?? "NONE SET")")
        }
    }
    
    @IBAction func connectToPort(_: AnyObject) {
        print("Button pressed!")
        
        // What are the available ports?
        print("serialPortManager: availablePorts = ")
        var i = 0
        for sport in serialPortManager.availablePorts {
            print("\t\(serialPortManager.availablePorts.index(of: sport) ?? -1). \(sport.path)")
            i += 1
        }
        
        // What is the currently selected port? Use that to attach port
        if let selected = portSelector.selectedItem {
            print("portSelector: selectedItem = \(selected.title) @ index \(portSelector.indexOfSelectedItem)")
            port = serialPortManager.availablePorts[portSelector.indexOfSelectedItem]
        } else {
            print("portSelector: selectedItem = (no selected item)")
            port = nil
        }
    }
    
    
    // MARK: - UI elements
    let topBar = NSView() // Toolbar at the top
    let panel = GSPanel() // Entire lower view. Holds all major subviews
    
    
    let portSelector = NSPopUpButton()
    let serialWindow = NSScrollView()
    let serialMonitor = NSTextView()
    
    let connectButton: NSButton = {
        let b = NSButton(title: "Connect", target: self, action: #selector(connectToPort(_:)))
        b.setButtonType(.momentaryPushIn)
        b.bezelStyle = .rounded
        b.setFrameSize(NSSize(width: 120, height: 25))
        return b
    }()
    
    
    
    
    
    // MARK: - Overrides
    override func viewDidAppear() {
        super.viewDidAppear()
        print("View did appear")
        view.window?.delegate = self
        
        configureTopBar() // Top Bar
        configurePanel() // Base panel. Holds all subviews. 
        configurePortSelector() // Port selector
        
        // Confirm size of elements
        print("Size of panel is \(panel.frame.size.width)x\(panel.frame.size.height)")
        print("Position of panel is \(panel.frame.origin.x)x\(panel.frame.origin.y)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading view")
        view.autoresizesSubviews = true
        
        
        print("View size: \(view.frame.size.width) by \(view.frame.size.height)")
        print("Port selector width: \(portSelector.frame.size.width)")
    }
    
}


// MARK: - Port Selection UI item
extension GSViewController {
    func configurePortSelector() {
        print("Setting up port selector")
        
        // Binding the port selector to the content of the serialPortManager
        portSelector.bind(.content, to: serialPortManager, withKeyPath: "availablePorts", options: nil) // Works
        portSelector.bind(.contentValues, to: serialPortManager, withKeyPath: "availablePorts.name", options: nil)
        // Handling port selection is done with button!
        //portSelector.bind(.selectedObject, to: port, withKeyPath: "self", options: nil)
        // ^^ serialPort, "self": Causes exception upon selection, for key "self"
        // ^^ self, "serialPort": not kvc compliant for key "serialPort"
        // ^^ port, "self": Causes exception upon selection, for key "self"
        // ^^ Ignore this line for now...?
        
        // Styling
        //        portSelector.setTitle("Port Selector")
        //        portSelector.bezelStyle = .roundRect
        //        portSelector.frame.size.width = 300.0 // Changeable
        //        portSelector.frame.size.height = 30.0 // Does not visually change
        //        portSelector.frame.origin = CGPoint(x: 50, y: 50)
        //        portSelector.bezelStyle = .rounded // THIS IS THE ONE
        //portSelector.addItem(withTitle: "No Port")
    }
}





// ***** Notes
/*
 Setting up buttons with selectors:
 1. Declare an IBAction function that takes (_: AnyObject) as a parameter.
 2. Somewhere within viewDidAppear, declare an NSButton with a title, target, and action:
        let button = NSButton(title: "Connect", target: self, action: #selector(self.testFunc))
 3. Set various properties on the button, including positionary stuff
         button.setButtonType(.momentaryPushIn)
         button.bezelStyle = .rounded
         button.translatesAutoresizingMaskIntoConstraints = true
         button.frame.origin = CGPoint(x: 400, y: 400)
         button.setFrameSize(NSSize(width: 100, height: 45))
 4. Add it to the view.
         view.addSubview(button)
 
 
 */
