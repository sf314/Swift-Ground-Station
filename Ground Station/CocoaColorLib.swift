//
//  ColorLib.swift
//  Checkout
//
//  Created by Stephen Flores on 12/27/15.
//  Copyright © 2015 Stephen Flores. All rights reserved.
//

import Foundation
import CoreGraphics
import Cocoa


public class CustomColorLibrary {
    // Welcome to the Colour Library!
    // To use, simply create a ColorLib object using the class CustomColorLibrary() to instantiate
        // Then you can assign your objects with ColorLib.someColor.someSubset
    
    let blue = Blues()
    let gray = Grays()
    let green = Greens()
    
}

// Blues
class Blues {
    let standard = CGColor(red: 0, green: 95/255, blue: 151/255, alpha: 1) // plusTax blue
    let light = NSColor(red: 0, green: 115/255, blue: 171/255, alpha: 1)
    let dark = NSColor(red: 0, green: 70/255, blue: 124/255, alpha: 1)
}

// Grays
class Grays {
    let standard = NSColor(red: 81/255, green: 86/255, blue: 95/255, alpha: 1) // plusTax gray
    let neutral = NSColor(red: 0.396248, green: 0.396248, blue: 0.396248, alpha: 1)
    let light = NSColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    let dark = NSColor(red: 63/255, green: 65/255, blue: 73/255, alpha: 1)
}

// Greens
class Greens {
    let standard = NSColor(red: 52/255, green: 171/255, blue: 58/255, alpha: 1)
    let oldeGS = NSColor(red: 137/255, green: 232/255, blue: 146/255, alpha: 1)
}

// Custom Colour declarations:

var usePeanutColours = true

var backgroundDark = NSColor(calibratedRed: 28/255, green: 28/255, blue: 34/255, alpha: 1)
var backgroundMed = NSColor(calibratedRed: 45/255, green: 47/255, blue: 58/255, alpha: 1)
var backgroundLight = NSColor(calibratedRed: 129/255, green: 135/255, blue: 138/255, alpha: 1)

let blueDark = NSColor(calibratedRed: 28/255, green: 28/255, blue: 34/255, alpha: 1)
let blueMed = NSColor(calibratedRed: 45/255, green: 47/255, blue: 58/255, alpha: 1)
let blueLight = NSColor(calibratedRed: 129/255, green: 135/255, blue: 138/255, alpha: 1)

let redDark = NSColor(calibratedRed: 54/255, green: 28/255, blue: 28/255, alpha: 1)
let redMed = NSColor(calibratedRed: 78/255, green: 47/255, blue: 45/255, alpha: 1)
let redLight = NSColor(calibratedRed: 158/255, green: 135/255, blue: 129/255, alpha: 1)
 
