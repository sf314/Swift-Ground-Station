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
    var max = 1.0
    var height = 0.0
    var width = 0.0
    var size = 200 // variable length?
    var debugMode = false
    
    let colors = CustomColorLibrary()
    
    
    func add(_ point: Double) {
        data.append(point)
        if data.count > size { // size controlled
            data.remove(at: 0)
        }
        if point > max { // Track max
            max = point
        }
    }
    
    // MARK: - Drawing
    override func draw(_ rect: NSRect) {
        if data.count == 0 {self.add(0.0)}
        super.draw(rect)
        
        // Draw background colour
        backgroundMed.set()
        bounds.fill()
        
        // Draw points (remember coordinate system!) 
        // TODO: - Points up to max should appear starting from the right side (fixed width?)
        // Solution: Init array with \(size) points 
        height = Double(self.frame.height) - 44.0 // Keep clear of label area
        width = Double(self.frame.width)
        let dx = width / Double(data.count) // Identify spacing width (dx) between points
        
        var x = 0.0
        for val in data {
            let rec = NSRect(x: x, y: map(val), width: 3, height: 3)
            let bez = NSBezierPath(roundedRect: rec, xRadius: 1.5, yRadius: 1.5)
            colors.green.oldeGS.set()
            bez.fill()
            x += dx
        }
    }
    
    func map(_ y: Double) -> Double {
        // Map double value y to within the bounds of the rect (flipped: the right way round)
        return (height * y / max)
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
    
    func generateTestPoints() {
//        for i in 1..<20 {
//            self.add(Double(i));
//        }
//        for i in 1..<20 {
//            self.add(Double(i));
//        }
//        for i in 1..<20 {
//            self.add(Double(i));
//        }
        add(12)
        add(12)
        add(12)
        add(12)
    }
    
    
}
