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

class GSViewController: NSViewController {
    
    @IBAction func buttonPressed(_ sender: NSButton) { // Use @Objc or @IBAction
        print("Button pressed! It was called " + sender.title)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        print("View did appear")
        // Draw UI here
        let button = NSButton(title: "My Button", target: self, action: #selector(self.buttonPressed))
        button.setButtonType(.momentaryPushIn)
        button.bezelStyle = .roundRect
        view.addSubview(button)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
        
        print(view.frame.size.width)
        
    }
}
