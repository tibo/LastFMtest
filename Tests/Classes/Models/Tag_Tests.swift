//
//  Tag_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class Tag_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let mock = ["name": "pop",
                "url": "http://www.last.fm/tag/pop"]

    func test_fillWithDictionary_withJSONFromSearchResult_shouldReturnRightValues()
    {
        var tag = Tag()
        tag.fillWithDictionary(mock)
        
        XCTAssert(tag.name! == "pop")
        XCTAssert(tag.url!.absoluteString == "http://www.last.fm/tag/pop")
    }
}
