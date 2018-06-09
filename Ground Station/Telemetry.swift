//
//  Telemetry.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/6/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

// This file defines the Telemetry class, and the valid operations on it.


import Foundation



class Telemetry {
    
    // Fields (init to zero)
    var met = 0.0
    var packetCount = 0
    var altitude = 0.0
    var pressure = 0.0
    var temp = 0.0
    var volt1 = 0.0
    var gps_time = 0.0
    var gps_lat = 0.0
    var gps_lon = 0.0
    var gps_alt = 0.0
    var gps_sats = 0
    var tilt_x = 0.0
    var tilt_y = 0.0
    var tilt_z = 0.0
    var state = 0
    var volt2 = 0.0
    // TODO: - 
    
    var prevAlt = 0.0
    
    // Set values based on packet (do not change if invalid)
    func set(using packet: String) {
        let parser = TelemParser()
        if parser.isValid(packet) {
            let fields = packet.split(separator: ",")
            
            prevAlt = altitude
            
            // TODO: - Make safer using if-let binding
            met = Double(fields[1])!
            packetCount = Int(fields[2])!
            altitude = Double(fields[3])!
            pressure = Double(fields[4])!
            temp = Double(fields[5])!
            volt1 = Double(fields[6])!
            gps_time = Double(fields[7])!
            gps_lat = Double(fields[8])! / 100.0
            gps_lon = Double(fields[9])! / -100.0
            gps_alt = Double(fields[10])!
            gps_sats = Int(fields[11])!
            tilt_x = Double(fields[12])!
            tilt_y = Double(fields[13])!
            tilt_z = Double(fields[14])!
            state = Int(fields[15])!
            volt2 = Double(fields[16])!
            
            
        } else {
            print("Telemetry.set: Invalid packet given to ingest")
        }
        
        print("Telemetry.set: Updated values. New altitude is \(altitude)")
    }
    
    
}
