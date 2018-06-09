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
import MapKit

class GSViewController: NSViewController, NSWindowDelegate, NSToolbarDelegate, ORSSerialPortDelegate {
    
    // MARK: - Data Variables
    let telem = Telemetry()
    let parser = TelemParser()
    var graphs: [GraphView] = [] // Hold graphs (can add to it!)
//    var graphItems: [GraphItem] = [] // Hold graph items (which themselves hold graphs)
//    var graphItems: [NSCollectionViewItem] = []
    
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
    
    // MARK: - Receive and parse data
    func addToSerialMonitor(_ s: String) {
        // TODO: - Fix scrolling of serial monitor!
        write(s, toFile: "RawData.txt")
        self.serialMonitor.textStorage?.mutableString.append("\(s)");
        
            // Actually, do a thing:
            strings.append(s)
            if strings.count > 4 {
                strings.removeFirst()
            }
            self.serialMonitor.textStorage?.mutableString.setString("")
            for s in strings {
                self.serialMonitor.textStorage?.mutableString.append(s)
            }
        
        self.serialMonitor.textColor = .white
        self.serialMonitor.frame.size.height += 14 // Hey it scrolls!
        self.serialMonitor.frame.size.width = serialWindow.contentView.frame.size.width // Necessary for some reason
        self.serialMonitor.needsDisplay = true
        self.serialMonitor.scrollToEndOfDocument(self)
        
        self.serialWindow.needsDisplay = true
        
        // *** Parse data here
        for character in s {
            parser.ingest(character)
        }
        
        while parser.hasPackets() {
            let packet = parser.popNext()
            if parser.isValid(packet) {
                print("Received packet: \(packet)")
                write(packet + "\n", toFile: "Packets.csv")
                telem.set(using: packet)
                updateGraphs(using: telem)
            }
        }
    }
    
    var strings: [String] = []
    func debugToSerialMonitor(_ s: String) {
        // Same as regular, but no parsing!
        self.serialMonitor.textStorage?.mutableString.append("\(s)");
        
            // Actually, do a thing:
            strings.append(s)
            if strings.count > 4 {
                strings.removeFirst()
            }
            self.serialMonitor.textStorage?.mutableString.setString("")
            for s in strings {
                self.serialMonitor.textStorage?.mutableString.append(s)
            }
        
        self.serialMonitor.textColor = .white
        self.serialMonitor.frame.size.height += 14 // Hey it scrolls!
        self.serialMonitor.frame.size.width = serialWindow.contentView.frame.size.width // Necessary for some reason
        self.serialMonitor.needsDisplay = true
        self.serialMonitor.scrollToEndOfDocument(self)
        
        self.serialWindow.needsDisplay = true
//        self.serialWindow.scrollToEndOfDocument(self.serialMonitor)
        
        
        print("serialWindow size: \(serialWindow.frame.size.width)x\(serialWindow.frame.size.height)")
        print("serialMonitor size: \(serialMonitor.frame.size.width)x\(serialMonitor.frame.size.height)")
    }
    
    // Mark: - Connect
    @IBAction func connectToPort(_ sender: AnyObject) {
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
            
            // Attempt smart stuff: Call the backend serial port connect func
            connect(sender as! NSButton)
        } else {
            print("portSelector: selectedItem = (no selected item)")
            port = nil
        }
        
        // Test file write
        write("Hey", toFile: "test.txt")
    }
    
    // MARK: - Send command
    @IBAction func sendCommand(_ sender: AnyObject) {
        // Sender should be of type NSTextField!
        let textField = sender as! NSTextField
        
        print("Sending \(textField.stringValue)")
        debugToSerialMonitor("Sending \(textField.stringValue)\n")
        
        if let data = (textField.stringValue).data(using: String.Encoding.utf8) {
            if let port = port {
                port.send(data)
                print("Successfully sent command")
            } else {
                debugToSerialMonitor("Failed to send command: port not defined\n")
            }
        } else {
            debugToSerialMonitor("Failed to send command: text was bad\n")
        }
    }
    
    // MARK: - Toggle save
    @IBAction func toggleSave(_ sender: AnyObject) {
        if enableFileWrite {
            print("Saving disabled")
            enableFileWrite = false
            toggleSaveButton.title = "Saving disabled"
        } else {
            print("Saving enabled");
            enableFileWrite = true
            toggleSaveButton.title = "Saving enabled"
        }
        print("File Write set to \(enableFileWrite)")
        
        updateSubviews(self.view)
    }
    
    
    // MARK: - UI elements
    let topBar = NSView() // Toolbar at the top
    let panel = GSPanel() // Entire lower view. Holds all major subviews
    let leftPanel = GSPanel() // Left side of the view
    let rightPanel = GSPanel() // Right side of the view
    let teamNum = NSTextView()
    
    let portSelector = NSPopUpButton()
    let serialWindow = NSScrollView()
    let serialMonitor = NSTextView() 
    var graphGridView = NSView()
    
    let commandStack = NSStackView()
    var commandViews: [NSStackView] = []
    
    let infoStack = NSStackView()
    let dataStack = NSStackView()
    let gpsStack = NSStackView()
        let metLabel = NSTextView()
        let packetLabel = NSTextView()
        let stateLabel = NSTextView()
        let velLabel = NSTextView()
        let gps_latLabel = NSTextView()
        let gps_lonLabel = NSTextView()
        let gps_satsLabel = NSTextView()
        let gps_timeLabel = NSTextView()
    let map = MKMapView()
    
    let connectButton: NSButton = {
//        let b = NSButton(title: "Connect", target: self, action: #selector(connectToPort(_:)))
        let b = NSButton(title: "Connect", target: self, action: #selector(connectToPort(_:)))
        b.setButtonType(.momentaryPushIn)
        b.bezelStyle = .rounded
        b.setFrameSize(NSSize(width: 120, height: 25))
        b.toolTip = "Connect to the selected port"
        return b
    }()
    
    let toggleSaveButton: NSButton = {
        let b = NSButton(title: "Saving disabled", target: self, action: #selector(toggleSave(_:)))
        b.setButtonType(.momentaryPushIn)
        b.bezelStyle = .rounded
        b.setFrameSize(NSSize(width: 120, height: 25))
        b.toolTip = "Enable or disable file saving"
        return b
    }()
    
    let testDataButton: NSButton = {
        let b = NSButton(title: "Test", target: self, action: #selector(ingestFakeData(_:)))
        b.setButtonType(.momentaryPushIn)
        b.bezelStyle = .rounded
        b.setFrameSize(NSSize(width: 120, height: 25))
        b.toolTip = "Generate a fake packet"
        return b
    }()
    
    let themeToggle: NSButton = {
        let b = NSButton(title: "CL", target: self, action: #selector(toggleColor(_:)))
        b.setButtonType(.momentaryPushIn)
        b.bezelStyle = .rounded
        b.setFrameSize(NSSize(width: 120, height: 25))
        b.toolTip = "Switch between blue and red themes"
        return b
    }()
    
    
    // MARK: - Overrides
    override func viewDidAppear() {
        super.viewDidAppear()
        print("View did appear")
        view.window?.delegate = self
        
        
        
        // Confirm size of elements
        print("Size of panel is \(panel.frame.size.width)x\(panel.frame.size.height)")
        print("Position of panel is \(panel.frame.origin.x)x\(panel.frame.origin.y)")
        print("Size of graphGridView is \(graphGridView.frame.size.width)x\(graphGridView.frame.size.height)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading view")
        view.autoresizesSubviews = true
        
        configureTopBar() // Top Bar
        configurePanel() // Base panel. Holds all subviews. 
        configurePortSelector() // Port selector
        configureGraphs() // Graph naming and stuff (after drawing)
        
        print("View size: \(view.frame.size.width) by \(view.frame.size.height)")
        print("Port selector width: \(portSelector.frame.size.width)")
        
        // Ensure the save filepath exists, and make it if it doesn't
        initTelemDir()
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
