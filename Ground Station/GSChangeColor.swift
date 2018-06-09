//
//  GSChangeColor.swift
//  Ground Station
//
//  Created by Stephen Flores on 6/7/18.
//  Copyright © 2018 Stephen Flores. All rights reserved.
//

// Make a way to change the theme of the UI (for Peanut v Butter)

import Foundation
import AppKit


extension GSViewController {
    
    func configureThemeToggle() {
        // Add button to the topBar, set its target
        
        topBar.addSubview(themeToggle)
        themeToggle.translatesAutoresizingMaskIntoConstraints = false
        themeToggle.trailingAnchor.constraint(equalTo: testDataButton.leadingAnchor, constant: -25).isActive = true
        themeToggle.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        themeToggle.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
    }
    
    // Declare function that sets colour and reloads UI
    @IBAction func toggleColor(_ o: AnyObject) {
        // Reset backgroundDark, backgroundMed, backgroundLight
        if usePeanutColours {
            // change to blues
            backgroundDark = blueDark
            backgroundMed = blueMed
            backgroundLight = blueLight
        } else {
            // change to reds
            backgroundDark = redDark
            backgroundMed = redMed
            backgroundLight = redLight
        }
        
        // Toggle and refresh
        usePeanutColours = !usePeanutColours
        serialMonitor.backgroundColor = backgroundMed
        panel.setColor(backgroundDark)
        leftPanel.setColor(backgroundDark)
        rightPanel.setColor(backgroundDark)
        updateSubviews(self.view)
    }
}
