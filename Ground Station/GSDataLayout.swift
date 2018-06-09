//
//  GSDataLayout.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/9/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import Foundation
import AppKit

// Layout the data segment in the bottom-left of the GS
// Two sides: One is general CS stuff, the other is GPS

extension GSViewController {
    
    func configureInfoStack() {
        // Two stacks! Just below commandStack, and within leftPanel
        infoStack.distribution = .fillEqually
        infoStack.orientation = .horizontal
        infoStack.autoresizesSubviews = true
        leftPanel.addSubview(infoStack)
        
        // Configure subviews
            dataStack.distribution = .fillEqually
            dataStack.orientation = .vertical
            dataStack.autoresizesSubviews = true
            infoStack.addView(dataStack, in: .leading)
                dataStack.addView(metLabel, in: .top)
                dataStack.addView(packetLabel, in: .top)
                dataStack.addView(stateLabel, in: .top)
                dataStack.addView(velLabel, in: .top)
            
            gpsStack.distribution = .fillEqually
            gpsStack.orientation = .vertical
            gpsStack.autoresizesSubviews = true
            infoStack.addView(gpsStack, in: .leading)
                gpsStack.addView(gps_latLabel, in: .top)
                gpsStack.addView(gps_lonLabel, in: .top)
                gpsStack.addView(gps_satsLabel, in: .top)
                gpsStack.addView(gps_timeLabel, in: .top)
        
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.topAnchor.constraint(equalTo: commandStack.bottomAnchor, constant: 15).isActive = true
        infoStack.leadingAnchor.constraint(equalTo: leftPanel.leadingAnchor, constant: 15).isActive = true
        infoStack.trailingAnchor.constraint(equalTo: leftPanel.trailingAnchor, constant: -15).isActive = true
        infoStack.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // Preset text load?
        let labels = [metLabel, packetLabel, stateLabel, velLabel, gps_timeLabel, gps_satsLabel, gps_lonLabel, gps_latLabel]
        for l in labels {
            l.backgroundColor = backgroundMed
            l.textColor = NSColor.white
        }
        
        metLabel.string = "MET: "
        packetLabel.string = "Packets: "
        stateLabel.string = "State: "
        velLabel.string = "Vel: "
        gps_latLabel.string = "Lat: "
        gps_lonLabel.string = "Lon: "
        gps_satsLabel.string = "Sats: "
        gps_timeLabel.string = "Time: "
    }
    
    
}
