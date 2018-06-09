//
//  GSVCLayout.swift
//  Ground Station
//
//  Created by Stephen Flores on 1/4/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

/*
 This file defines simplified functions for setting up UI layout using 
 constraints. 
*/
import Foundation
import AppKit
import Cocoa
import CoreGraphics


extension GSViewController {
    func configureTopBar() {
        print("Configuring top bar")
        
        view.addSubview(topBar)
        
        //topBar.fillColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) // Same as regular top bar, created using ColorLiteral
        //topBar.titlePosition = .noTitle
        //topBar.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false // needs to be false!!!
        topBar.topAnchor.constraint(equalTo: (view.window?.contentView?.topAnchor)!).isActive = true // yassss
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topBar.addSubview(portSelector)
        portSelector.setTitle("Port Selector")
        portSelector.bezelStyle = .roundRect
        portSelector.frame.size.width = 300.0 // Changeable
        portSelector.translatesAutoresizingMaskIntoConstraints = false
        portSelector.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 10).isActive = true
        portSelector.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        portSelector.bezelStyle = .rounded // THIS IS THE ONE
        
        //let button = NSButton(frame: NSRect(x: 0, y: 0, width: 40, height: 40))
        topBar.addSubview(connectButton)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.leadingAnchor.constraint(equalTo: portSelector.trailingAnchor, constant: 15).isActive = true
        connectButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        topBar.addSubview(toggleSaveButton)
        toggleSaveButton.translatesAutoresizingMaskIntoConstraints = false
        toggleSaveButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        toggleSaveButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -30).isActive = true
        toggleSaveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        configureTestDataIngest()
        configureThemeToggle()
    }
}


// Generate custom panel that can change the background color. Use for all views!
class GSPanel: NSView {
    
    var backgroundColour = NSColor(calibratedRed: 28/255, green: 28/255, blue: 34/255, alpha: 1)
    
    func setColor(_ color: NSColor) {
        backgroundColour = color
    }
    
    override func draw(_ dirtyRect: NSRect) {
        
        // Generate rectangle that fills frame
        //let backgroundColour = NSColor(calibratedRed: 28/255, green: 28/255, blue: 34/255, alpha: 1)
        backgroundColour.set()
        bounds.fill() // Not NSRectFill(bounds) anymore!
    }
}

extension GSViewController {
    // Configure the main panel, and all subpanels
    func configurePanel() {
        print("Configuring panel")
        view.addSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        panel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        panel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        panel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        panel.autoresizesSubviews = true
        
        configureLeftPanel()
        configureRightPanel()
    }
    
    func configureLeftPanel() {
        // Configure left side of screen, including serial monitor, map, etc
        print("Configuring left panel")
        panel.addSubview(leftPanel)
        
        leftPanel.translatesAutoresizingMaskIntoConstraints = false
        leftPanel.translatesAutoresizingMaskIntoConstraints = false
        leftPanel.topAnchor.constraint(equalTo: panel.topAnchor).isActive = true
        leftPanel.leadingAnchor.constraint(equalTo: panel.leadingAnchor).isActive = true
        leftPanel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        leftPanel.bottomAnchor.constraint(equalTo: panel.bottomAnchor).isActive = true
        
        leftPanel.autoresizesSubviews = true
        
        configureSerialMonitor()
        configureCommandPanel()
    }
    
    func configureRightPanel() {
        print("Configuring right panel")
        
        // Configure right side of screen. Primarily graphs in a flow-layout, yea?
        panel.addSubview(rightPanel)
        rightPanel.translatesAutoresizingMaskIntoConstraints = false
        rightPanel.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        rightPanel.leadingAnchor.constraint(equalTo: leftPanel.trailingAnchor).isActive = true
        rightPanel.trailingAnchor.constraint(equalTo: panel.trailingAnchor).isActive = true
        rightPanel.bottomAnchor.constraint(equalTo: panel.bottomAnchor).isActive = true
        
        rightPanel.autoresizesSubviews = true
        rightPanel.setColor(backgroundDark)
        
        // Create 8 graphs
        for i in 0..<8 {
            let graph = GraphView()
            graph.name = "Graph " + String(i)
            graphs.append(graph)
//            let dat = Double(i) * 20.0
//            print("Generating graph with data value \(dat)")
//            for _ in 0..<5 {
//                graph.add(dat)
//            }
        }
        // Create dummy graph
        let dummyGraph = GraphView()
        dummyGraph.name = "Dummy Graph"
        graphs.append(dummyGraph)
    
        rightPanel.addSubview(graphGridView)
        graphGridView.translatesAutoresizingMaskIntoConstraints = false // Below is proper inset values
        graphGridView.topAnchor.constraint(equalTo: rightPanel.topAnchor, constant: 20).isActive = true
        graphGridView.leadingAnchor.constraint(equalTo: rightPanel.leadingAnchor, constant: 20).isActive = true
        graphGridView.trailingAnchor.constraint(equalTo: rightPanel.trailingAnchor, constant: -20).isActive = true
        graphGridView.bottomAnchor.constraint(equalTo: rightPanel.bottomAnchor, constant: -20).isActive = true
        
        // *****  Bahhhh! Use stackviews?
        
        // 1. Declare main stack, assign distribution properties, and add it to view hierarchy
        let rowStack = NSStackView(frame: graphGridView.frame)
        rowStack.distribution = .fillEqually
        rowStack.orientation = .vertical
        rowStack.autoresizesSubviews = true
        graphGridView.addSubview(rowStack)
        
        // 2. Declare your subviews, add them to the view hierarcy
        let row1 = NSStackView(views: [graphs[0], graphs[1], graphs[2]])
        let row2 = NSStackView(views: [graphs[3], graphs[4], graphs[5]])
        let row3 = NSStackView(views: [graphs[6], graphs[7], NSView()])
        
        rowStack.addView(row1, in: .top)
        rowStack.addView(row2, in: .top)
        rowStack.addView(row3, in: .top)
        
        // 3. Set AutoLayout constraints on the main stack
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        rowStack.topAnchor.constraint(equalTo: graphGridView.topAnchor).isActive = true
        rowStack.bottomAnchor.constraint(equalTo: graphGridView.bottomAnchor).isActive = true
        rowStack.leadingAnchor.constraint(equalTo: graphGridView.leadingAnchor).isActive = true
        rowStack.trailingAnchor.constraint(equalTo: graphGridView.trailingAnchor).isActive = true
        
        // 4. Assign distribution properties of the subviews
        row1.distribution = .fillEqually
        row1.autoresizesSubviews = true
        
        row2.distribution = .fillEqually
        row2.autoresizesSubviews = true
        
        row3.distribution = .fillEqually
        row3.autoresizesSubviews = true
        
        print("Finished configuring right panel")

    }
    
}

extension GSViewController {
    
    // Configure the serial monitor: A simple text view
    func configureSerialMonitor() {
        print("Configuring serial monitor")
        // Both the serial window (ScrollView), and text itself (TextView)
        serialWindow.backgroundColor = .red
        serialMonitor.backgroundColor = backgroundMed
        serialMonitor.textColor = .white
        
        // *** Scroll View: serialWindow
        leftPanel.addSubview(serialWindow)
        serialWindow.translatesAutoresizingMaskIntoConstraints = false
        serialWindow.topAnchor.constraint(equalTo: leftPanel.topAnchor, constant: 15).isActive = true
        serialWindow.leadingAnchor.constraint(equalTo: leftPanel.leadingAnchor, constant: 15).isActive = true
        serialWindow.trailingAnchor.constraint(equalTo: leftPanel.trailingAnchor, constant: -15).isActive = true // Remember your coord system!
        serialWindow.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        serialWindow.autoresizesSubviews = true
        serialWindow.documentView = serialMonitor // KEEP
        serialWindow.scrollsDynamically = true
        
        // *** Text View: serialMonitor
//        serialWindow.addSubview(serialMonitor)
        serialMonitor.translatesAutoresizingMaskIntoConstraints = false
        serialMonitor.topAnchor.constraint(equalTo: serialWindow.topAnchor).isActive = true
        serialMonitor.leadingAnchor.constraint(equalTo: serialWindow.leadingAnchor).isActive = true
        serialMonitor.trailingAnchor.constraint(equalTo: serialWindow.trailingAnchor).isActive = true // I SEE TEXT AGAIN YAS
        serialMonitor.heightAnchor.constraint(equalTo: serialWindow.heightAnchor).isActive = true // Necessary for scrolling (?)
        serialMonitor.minSize.width = serialWindow.frame.width
        serialMonitor.minSize.height = serialWindow.frame.height
        serialMonitor.textContainerInset = NSSize(width: 10, height: 0)
        
        // How to get it to autoscroll:
        serialWindow.hasVerticalScroller = true
        serialMonitor.sizeToFit()
        // Warning: Height for serialMonitor is ambiguous since it changes
        
        serialMonitor.isEditable = false
//        serialMonitor.layoutManager?.hasNonContiguousLayout = true
        serialMonitor.isVerticallyResizable = true //??
        
        // NEW
//        serialWindow.automaticallyAdjustsContentInsets = true
    }
}

extension GSViewController {
    
    
    func configureCommandPanel() {
        // Create stack views: 2 x 4, all settable
        
        
        // 1. Gen main stack and set distribution properties, and add it to the subview
        commandStack.distribution = .fillEqually
        commandStack.orientation = .vertical
        commandStack.autoresizesSubviews = true
        leftPanel.addSubview(commandStack)
        
        // 1.1: add a label to the top (instead of doing tooltips)
        let label = NSTextView()
        label.string = "Command Panel: Hit enter to send"
        label.backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0)
        label.textColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 1)
        label.alignment = .center
        commandStack.addView(label, in: .top)
        
        // 2. Generate all n command subviews, add them
        let numberOfCommands = 5
        for _ in 0..<numberOfCommands {
            let commandView = NSStackView()
            commandView.distribution = .fillEqually
            commandView.orientation = .horizontal
            commandView.autoresizesSubviews = true
            
            let inputField = NSTextField()
            let inputField2 = NSTextField()
//            let sendButton = NSButton()
            
            commandView.addView(inputField, in: .leading)
            commandView.addView(inputField2, in: .leading)
//            commandView.addView(sendButton, in: .leading)
            commandViews.append(commandView)
            
            commandStack.addView(commandView, in: .top)
            commandView.widthAnchor.constraint(equalTo: commandStack.widthAnchor).isActive = true
            
            inputField.target = self
            inputField.action = #selector(sendCommand(_:))
            inputField2.target = self
            inputField2.action = #selector(sendCommand(_:))
//            sendButton.action = inputField.action
            
            inputField.toolTip = "Press enter to send command"
            inputField2.toolTip = "Press enter to send command"
        }
        
        // 3. Set AutoLayout constraints on main stack
        commandStack.translatesAutoresizingMaskIntoConstraints = false
        commandStack.topAnchor.constraint(equalTo: serialWindow.bottomAnchor, constant: 15).isActive = true
        commandStack.heightAnchor.constraint(equalToConstant: CGFloat(30 * numberOfCommands)).isActive = true
        commandStack.leadingAnchor.constraint(equalTo: leftPanel.leadingAnchor, constant: 15).isActive = true
        commandStack.trailingAnchor.constraint(equalTo: leftPanel.trailingAnchor, constant: -15).isActive = true
        
        // 4. Set preset text for commands 1-4 (of 5)
        (commandViews[0].views[0] as! NSTextField).stringValue = "x"
        (commandViews[1].views[0] as! NSTextField).stringValue = "b"
        (commandViews[2].views[0] as! NSTextField).stringValue = "c"
        (commandViews[3].views[0] as! NSTextField).stringValue = "?"
        
        (commandViews[0].views[1] as! NSTextField).stringValue = "0"
        (commandViews[1].views[1] as! NSTextField).stringValue = "1"
        (commandViews[2].views[1] as! NSTextField).stringValue = "2"
        (commandViews[3].views[1] as! NSTextField).stringValue = "3"
    }
}




extension GSViewController {
    // Window delegate stuff (for resizing)
    
     // Updates live!!!!
    func windowDidResize(_ notification: Notification) {
        // set view size to match window
        if let win = view.window {
            view.frame = win.frame
            view.setFrameOrigin(NSPoint(x: 0, y: 0))
        }
        
        updateSubviews(view)
        serialMonitor.scrollToEndOfDocument(self)
    }
    
    func updateSubviews(_ v: NSView) {
        // Recursively update all subviews of all views
        v.needsDisplay = true
        for subview in v.subviews {
            subview.updateConstraints()
            updateSubviews(subview)
        }
    }
    
}
