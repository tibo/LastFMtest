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
        
        LFMAPIClient.searchArtist("Salut C'est Cool", callback: { (artists, error, hasNext) -> Void in
            expectation.fulfill()
            
            XCTAssertFalse(hasNext, "should not had next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndNoPage_shouldHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage1_shouldHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 1, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage2_shouldHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 2, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage3_shouldHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 3, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage4_shouldHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 4, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage5_shouldNotHaveNext() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 5, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssertFalse(haveNext, "should not have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
}
