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
        
        topBar.addSubview(testDataButton)
        
        testDataButton.translatesAutoresizingMaskIntoConstraints = false
        testDataButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        testDataButton.trailingAnchor.constraint(equalTo: toggleSaveButton.leadingAnchor, constant: -15).isActive = true
        testDataButton.widthAnchor.constraint(equalToConstant: 70)
    
    }
    
}
