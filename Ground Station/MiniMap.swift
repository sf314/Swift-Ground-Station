//
//  MiniMap.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/12/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import Cocoa

class MiniMap: NSView {
    // MARK: - Data Variables
    var data: [(Double, Double)] = []
    var debugMode = false
    
    // MARK: - Modify Data
    func add(_ x: Double, _ y: Double) {
        data.append((x, y))
        debug("Appended (\(x), \(y) to minimap")
    }
    
    // MARK: - Drawing
    
    // Override drawing function (call with updateDisplay)
    override func draw(_ rect: NSRect) {
        super.draw(rect)
    }
    
    func updateDisplay() {
        self.setNeedsDisplay(self.bounds)
    }
    
    // MARK: - Debugging
    func debug(_ s: String) {
        if debugMode {
            print(s)
        }
    }
}
