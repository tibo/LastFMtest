//
//  NSURL+urlBuilder_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 13/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class NSURL_urlBuilder_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_URLWithBaseURL_withValidURLMethodAndParams_shouldReutnrValidURL() {

        var params = ["artist" : "Salut", "api_key" : "57b5a22d4a903735457999270a03664c", "format" : "json"]
        
        let url = NSURL.URLWithBaseURL("http://ws.audioscrobbler.com/2.0/", method: "artist.search", params: params)
        
        if let u = url?
        {
            XCTAssert(u.absoluteString == "http://ws.audioscrobbler.com/2.0/?method=artist.search&format=json&artist=Salut&api_key=57b5a22d4a903735457999270a03664c")
        }
        else
        {
            XCTFail("url should be not nil")
        }
        
    }
}
