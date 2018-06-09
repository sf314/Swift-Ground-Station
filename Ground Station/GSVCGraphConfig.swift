//
//  GSVCGraphConfig.swift
//  Ground Station
//
//  Created by Stephen Flores on 5/19/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import Foundation

// Extend GSViewController to configure graph properties (call in viewDidAppear)


extension GSViewController {
    
    func configureGraphs() {
        // Assign types to the graphs (according to GraphType enum)
        graphs[0].type = .alt
        graphs[1].type = .press
        graphs[2].type = .temp
        
        graphs[3].type = .volt1
        graphs[4].type = .volt2
        graphs[5].type = .gps_alt
        
        graphs[6].type = .tilt_x
        graphs[7].type = .tilt_y
        graphs[8].type = .tilt_z
        
        graph(for: .alt).set(name: "Alt", unit: "m")
        graph(for: .press).set(name: "Press", unit: "Pa")
        graph(for: .temp).set(name: "Temp", unit: "°C")
        graph(for: .volt1).set(name: "Volt 1", unit: "V")
        graph(for: .gps_alt).set(name: "GPS Alt", unit: "m")
        graph(for: .tilt_x).set(name: "Tilt X", unit: "°/sec")
        graph(for: .tilt_y).set(name: "Tilt Y", unit: "°/sec")
        graph(for: .tilt_z).set(name: "Tilt Z", unit: "°/sec")
        graph(for: .volt2).set(name: "Volt 2", unit: "V")
    }
    
    func graph(for type: GraphType) -> GraphView {
        for graph in graphs {
            if graph.type == type {
                return graph
            }
        }
        print("GSViewController.graph(for type: _): ERROR: No graph found for type \(type)")
        return GraphView()
    }
}
