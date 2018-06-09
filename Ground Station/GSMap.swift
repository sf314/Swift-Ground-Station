//
//  GSMap.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/9/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

import Foundation
import AppKit
import MapKit

extension GSViewController {
    
    func configureMap() {
        // Fill remaining space in left panel, below infoStack?
        leftPanel.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 15).isActive = true
        map.leadingAnchor.constraint(equalTo: leftPanel.leadingAnchor, constant: 15).isActive = true
        map.trailingAnchor.constraint(equalTo: leftPanel.trailingAnchor, constant: -15).isActive = true
        map.bottomAnchor.constraint(equalTo: leftPanel.bottomAnchor, constant: -15).isActive = true
        map.showsUserLocation = true
        map.showsScale = true
        map.showsCompass = true
        map.mapType = .hybrid
        
        map.setCenter(CLLocationCoordinate2D(latitude: 32.1845, longitude: -98.2547), animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 32.185, longitude: -98.26)
        map.addAnnotation(pin)
    }
}
