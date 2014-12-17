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
            
            XCTAssert(artists!.count == 1, "should have one result")
            XCTAssertFalse(hasNext, "should not have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndNoPage_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 30, "should have 30 result")
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage1_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 1, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 30, "should have 30 result")
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage2_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 2, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 30, "should have 30 result")
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage3_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 3, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 30, "should have 30 result")
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage4_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 4, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 30, "should have 30 result")
            XCTAssert(haveNext, "should have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistSearch_withSearchSalutAndPage5_shouldHaveValidResult() {
        let expectation = self.expectationWithDescription("test artist.search")
        
        LFMAPIClient.searchArtist("Salut", page: 5, callback: { (artists, error, haveNext) -> Void in
            expectation.fulfill()
            
            XCTAssert(artists!.count == 25, "should have 25 result")
            XCTAssertFalse(haveNext, "should not have next")
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistGetinfo_withArtistWithMDIB_shouldReturnValidResult() {
        var a = Artist()
        a.mbid = "70c0cd8b-a942-4b8f-b421-b2b5218e23b6"
        
        let expectation = self.expectationWithDescription("test artist.getinfo")
        
        LFMAPIClient.getInfoForArtist(a, callback: { (artist, error) -> Void in
            expectation.fulfill()
            
            if let wrappedArtist = artist?
            {
                XCTAssertEqual(a, wrappedArtist, "artist should be the same instance")
                
                // test some values
                XCTAssert(wrappedArtist.url!.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool")
                XCTAssert(wrappedArtist.images!["mega"]!.absoluteString == "http://userserve-ak.last.fm/serve/500/95960219/Salut+Cest+Cool+salut.jpg")
                XCTAssertFalse(wrappedArtist.onTour)
                
                XCTAssert(wrappedArtist.similars!.count == 5)
                XCTAssert(wrappedArtist.tags!.count == 5)
            }
            else
            {
                XCTFail("artist should not be nil")
            }
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
    
    func test_artistGetinfo_withArtistWithName_shouldReturnValidResult() {
        var a = Artist()
        a.name = "Cher"
        
        let expectation = self.expectationWithDescription("test artist.getinfo")
        
        LFMAPIClient.getInfoForArtist(a, callback: { (artist, error) -> Void in
            expectation.fulfill()
            
            if let wrappedArtist = artist?
            {
                XCTAssertEqual(a, wrappedArtist, "artist should be the same instance")
                
                // test some values
                XCTAssert(wrappedArtist.url!.absoluteString == "http://www.last.fm/music/Cher")
                XCTAssert(wrappedArtist.images!["mega"]!.absoluteString == "http://userserve-ak.last.fm/serve/500/63186903/Cher.png")
                XCTAssertTrue(wrappedArtist.onTour)
                
                XCTAssert(wrappedArtist.similars!.count == 5)
                XCTAssert(wrappedArtist.tags!.count == 5)
            }
            else
            {
                XCTFail("artist should not be nil")
            }
            
        })
        
        waitForExpectationsWithTimeout(60, handler: { error in
            
        })
    }
}
