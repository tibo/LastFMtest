//
//  Artist_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 16/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class Artist_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let mock = ["name": "Salut C'est Cool",
        "listeners": "940664",
        "mbid": "70c0cd8b-a942-4b8f-b421-b2b5218e23b6",
        "url": "http://www.last.fm/music/Salut+C%27est+Cool",
        "streamable": "0",
        "image": [  ["#text" : "http://userserve-ak.last.fm/serve/34/95960219.jpg", "size" : "small"],
                    ["#text" : "http://userserve-ak.last.fm/serve/64/95960219.jpg", "size" : "medium"],
                    ["#text" : "http://userserve-ak.last.fm/serve/126/95960219.jpg", "size" : "large"],
                    ["#text" : "http://userserve-ak.last.fm/serve/252/95960219.jpg", "size" : "extralarge"],
                    ["#text" : "http://userserve-ak.last.fm/serve/500/95960219/Salut+Cest+Cool+salut.jpg", "size" : "mega"]]]

    func test_fillWithDictionary_withJSONFromSearchResult_shouldReturnRightValues()
    {
        var artist = Artist()
        artist.fillWithDictionary(mock)
        
        XCTAssert(artist.name == "Salut C'est Cool", "")
        XCTAssert(artist.listeners == 940664, "")
        XCTAssert(artist.mbid == "70c0cd8b-a942-4b8f-b421-b2b5218e23b6", "")
        
        if let url = artist.url?
        {
            XCTAssert(url.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool", "")
        }
        else
        {
            XCTFail("url should not be nil")
        }
        
        if let images = artist.images?
        {
            if let img = images["small"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/34/95960219.jpg", "")
            }
            else
            {
                XCTFail("should have small image")
            }
            
            if let img = images["medium"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/64/95960219.jpg", "")
            }
            else
            {
                XCTFail("should have medium image")
            }
            
            if let img = images["large"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/126/95960219.jpg", "")
            }
            else
            {
                XCTFail("should have large image")
            }
            
            if let img = images["extralarge"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/252/95960219.jpg", "")
            }
            else
            {
                XCTFail("should have extralarge image")
            }
            
            if let img = images["mega"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/500/95960219/Salut+Cest+Cool+salut.jpg", "")
            }
            else
            {
                XCTFail("should have mega image")
            }
            
        }
        else
        {
            XCTFail("images should not be nil")
        }
    }

}
