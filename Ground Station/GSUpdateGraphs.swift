//
//  GSUpdateGraphs.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/6/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

// Extension for updating graphs using telemetry

import AppKit
import MapKit
import Foundation


extension GSViewController {
    
    func updateGraphs(using telem: Telemetry) {
        print("GS.updateGraphs: updating graphs")
        // use GSViewController.graph(for type: GraphType)
        graph(for: .alt).add(telem.altitude)
        graph(for: .temp).add(telem.temp)
        graph(for: .press).add(telem.pressure)
        graph(for: .volt1).add(telem.volt1)
        graph(for: .gps_alt).add(telem.gps_alt)
        graph(for: .tilt_x).add(telem.tilt_x)
        graph(for: .tilt_y).add(telem.tilt_y)
        graph(for: .tilt_z).add(telem.tilt_z)
        graph(for: .volt2).add(telem.volt2)
        
        for graph in graphs {
            graph.updateDisplay()
        }
        
        metLabel.string = "MET: \(telem.met)"
        packetLabel.string = "Packets: \(telem.packetCount)"
        stateLabel.string = "State: \(telem.state)"
        velLabel.string = "Vel: \(telem.altitude - telem.prevAlt)"
        gps_latLabel.string = "Lat: \(telem.gps_lat)"
        gps_lonLabel.string = "Lon: \(telem.gps_lon)"
        gps_satsLabel.string = "Sats: \(telem.gps_sats)"
        gps_timeLabel.string = "Time: \(telem.gps_time)"
        
        if (telem.gps_lat != 0.00 && telem.gps_lon != 0.00) {
            let pin = MKPointAnnotation()
            let lat = convertToDeg(telem.gps_lat)
            let lon = convertToDeg(telem.gps_lon)
            pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            map.addAnnotation(pin)
            if map.annotations.count > 50 {
                map.removeAnnotation(map.annotations.first!)
            }
        }
        
        print("GS.updateGraphs: updated graphs. Data points for alt are \(graph(for: .alt).data.last!)")
    }
    
    
    func convertToDeg(_ coord: Double) -> Double {
        // First two digits are deg
        // Next two are min
        // Next two are sec
        var coordString = String(coord)
        
        var prefix = 1.0
        if coordString.contains("-") {
            prefix = -1.0
            coordString = coordString.replacingOccurrences(of: "-", with: "")
        }
        coordString = coordString.replacingOccurrences(of: ".", with: "")
        
        if coordString.count != 6 {
            return 0.0
        }
        
        let deg = Double(coordString.prefix(2))!
        coordString.removeFirst(2)
        
        let min = Double(coordString.prefix(2))!
        coordString.removeFirst(2)
        
        let sec = Double(coordString.prefix(2))!
        coordString.removeFirst(2)
        
        return prefix * (deg + min/60.0 + sec / 3600.0)
    }
    
}
