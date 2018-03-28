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
        let testStrings = ["One, two, th", "ree, four, fi", "ve\nOne, t", "wo, three", ", four, five\n"]
        let parser = Parser(delimiter: "\n")
        
        for s in testStrings {
            parser.add(s)
            
            while (parser.hasLine()) {
                print("Has line: ", terminator: "")
                print(parser.getNextLine())
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
