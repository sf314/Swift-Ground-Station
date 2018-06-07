//
//  GSTestDataIngest.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/6/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import AppKit
import Foundation


extension GSViewController {
    
    @IBAction func ingestFakeData(_ sender: AnyObject) {
        print("Sending in fake data for ingest...")
        // Simulate incoming data
        addToSerialMonitor(fakePacket() + "\r\n")
    }
    
    func configureTestDataIngest() {
        let testDataButton: NSButton = {
            let b = NSButton(title: "Make Fake", target: self, action: #selector(ingestFakeData(_:)))
            b.setButtonType(.momentaryPushIn)
            b.bezelStyle = .rounded
            b.setFrameSize(NSSize(width: 120, height: 25))
            return b
        }()
        
        topBar.addSubview(testDataButton)
        
        testDataButton.translatesAutoresizingMaskIntoConstraints = false
        testDataButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        testDataButton.trailingAnchor.constraint(equalTo: toggleSaveButton.leadingAnchor, constant: -30).isActive = true
        testDataButton.widthAnchor.constraint(equalToConstant: 150)
    }
    
}
