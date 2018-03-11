//
//  GraphView.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/23/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

/*
 Subclass of NSView that implements graphing functionality. Will hold n number
 of data points between max and min. The maximum and minimum values will be
 displayed on the left margin.
 
 Data points to graph (8, including all of tilt sensor):
 Altitude
 Pressure
 Temp
 Voltage
 GPS altitude
 Tilt X/Y/Z
 */

import Foundation
import Cocoa


class GraphView: NSView {
    
    // MARK: - Data variables and manipulation
    var data: [Double] = []
    
    var min = 0.0
    var max = 0.0
    var size = 100 // variable length?
    var debugMode = false
    
    func add(_ point: Double) {
        data.append(point)
        if data.count > size {
            data.remove(at: 0)
        }
    }
    
    // MARK: - Drawing
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
