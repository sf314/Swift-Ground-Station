//
//  GSUpdateGraphs.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/6/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

// Extension for updating graphs using telemetry

import Foundation


extension GSViewController {
    
    func updateGraphs(using telem: Telemetry) {
        print("GS.updateGraphs: updating graphs")
        // use GSViewController.graph(for type: GraphType)
        graph(for: .alt).add(telem.altitude)
        graph(for: .temp).add(telem.temp)
        graph(for: .press).add(telem.pressure)
        graph(for: .volt).add(telem.volt)
        graph(for: .gps_alt).add(telem.gps_alt)
        graph(for: .tilt_x).add(telem.tilt_x)
        graph(for: .tilt_y).add(telem.tilt_y)
        graph(for: .tilt_z).add(telem.tilt_z)
        
        for graph in graphs {
            graph.updateDisplay()
        }
        
        print("GS.updateGraphs: updated graphs. Data points for alt are \(graph(for: .alt).data.last!)")
    }
    
}
