//
//  LFMAPIClient_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 13/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class LFMAPIClient_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_artistSearch_withSearch_shouldReturnValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut C'est Cool", callback: { (artists, error) -> Void in
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
}
