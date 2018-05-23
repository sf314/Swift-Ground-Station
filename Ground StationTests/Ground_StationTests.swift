//
//  Ground_StationTests.swift
//  Ground StationTests
//
//  Created by Stephen Flores on 11/10/17.
//  Copyright © 2017 Stephen Flores. All rights reserved.
//

import XCTest
@testable import Ground_Station

class Ground_StationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testParser() {
        // Generate array of test strings
        print("Generating test stream")
        var testStream = ""
        for _ in 0..<20 { // 20 fake packets worth of stream data
            testStream += fakePacket() + "\r\n"
        }
        
        // Create parser
        let parser = TelemParser()
        
        // Split testStream into segments of 16 chars (but keep \r\n together?)
        print("Splitting test stream into segments of 16")
        var streamSegments: [String] = []
        while testStream.count > 16 {
            var temp = ""
            for _ in 0..<16 {
                temp += String(testStream.removeFirst())
            }
            streamSegments.append(temp)
        }
        
        // Simulate receiver
        // Each iteration of outer loop represents one burst from receiver.
        print("Simulating receiver")
        for seg in streamSegments {
            // Feed chars of received data to parser
            print("Received segment \(seg)")
            for c in seg {
                parser.ingest(c)
            }
            
            // Read data from parser, assert validity
            while parser.hasPackets() {
                let packet = parser.popNext()
                print("Dequeue packet: \(packet)")
                XCTAssert(parser.isValid(packet))
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
