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
        
        // Add graphs in a flow layout kinda style
        rightPanel.setColor(backgroundDark)
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
        serialMonitor.translatesAutoresizingMaskIntoConstraints = false
        serialMonitor.topAnchor.constraint(equalTo: serialWindow.topAnchor).isActive = true
        serialMonitor.leadingAnchor.constraint(equalTo: serialWindow.leadingAnchor).isActive = true
        serialMonitor.trailingAnchor.constraint(equalTo: serialWindow.trailingAnchor).isActive = true // I SEE TEXT AGAIN YAS
        serialMonitor.heightAnchor.constraint(greaterThanOrEqualTo: serialWindow.heightAnchor).isActive = true // Necessary for scrolling (?)
        serialMonitor.minSize.width = serialWindow.frame.width
        serialMonitor.minSize.height = serialWindow.frame.height
        serialMonitor.textContainerInset = NSSize(width: 10, height: 0)
        
        // How to get it to autoscroll:
        serialWindow.hasVerticalScroller = true
        serialMonitor.sizeToFit()
        // Warning: Height for serialMonitor is ambiguous since it changes
        
        serialMonitor.isEditable = true
    }
}

extension GSViewController {
    
    
    func configureCommandPanel() {
//        // Create subview 
//        let subview = NSView()
//        view.addSubview(subview)
//        
//        // Generate constraints
//        subview.topAnchor.constraint(equalTo: topBar.bottomAnchor)
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
