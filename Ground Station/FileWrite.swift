//
//  FileWrite.swift
//  Ground Station
//
//  Created by Stephen Flores on 3/22/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import Foundation

/* File Write
 Enable functionality to write strings to a file on the desktop
 Automatically apply newlines? Idk
 Support customizable filenames
 Toggle file write with boolean flag
 */

let telemetryFile = "telemetry.csv"
let logFile = "log.txt"
var enableFileWrite = true

func write(_ s: String, toFile fileName: String) {
    if enableFileWrite {
        // Create document URL for filename
        let directoryUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0] as NSURL
        let fileUrl = directoryUrl.appendingPathComponent(fileName)
        
        // Save
        if let outStream = OutputStream(toFileAtPath: fileUrl!.absoluteString, append: true) {
            outStream.open()
            let length = s.lengthOfBytes(using: .utf8)
            outStream.write(s, maxLength: length)
            outStream.close()
        } else {
            print("Could not write to disk!")
        }
    }
}
