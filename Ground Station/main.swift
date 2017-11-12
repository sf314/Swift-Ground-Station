//
//  main.swift
//  Ground Station
//
//  Created by Stephen Flores on 11/10/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import Foundation
import Cocoa

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate
let returnCode = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv) // Start app runloop
