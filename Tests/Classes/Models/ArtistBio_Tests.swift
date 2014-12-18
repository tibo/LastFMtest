//
//  ArtistBio_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class ArtistBio_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    let mock = [ "links": [
            "link": [
                "#text": "",
                "rel": "original",
                "href": "http://www.last.fm/music/Salut+C%27est+Cool/+wiki"
            ]
        ],
        "published": "Sat, 7 Jun 2014 17:04:37 +0000",
        "summary": "\n                En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    ",
        "content": "\n                    En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    \nUser-contributed text is available under the Creative Commons By-SA License and may also be available under the GNU FDL.\n    "]

    func test_fillWithDictionary_withJSONFromSearchResult_shouldReturnRightValues()
    {
        var bio = ArtistBio()
        bio.fillWithDictionary(mock)
        
        XCTAssert(bio.originalURL!.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool/+wiki")
        
        XCTAssert(bio.summary! == "\n                En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    ")
        
        XCTAssert(bio.content! == "\n                    En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    \nUser-contributed text is available under the Creative Commons By-SA License and may also be available under the GNU FDL.\n    ")
        
        if let date = bio.publishDate?
        {
            let GMT_timeZone: NSTimeZone! = NSTimeZone(forSecondsFromGMT: 0)
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSGregorianCalendar)
            calendar.timeZone = GMT_timeZone
            let dateComponents = calendar.components(NSCalendarUnit(UInt.max), fromDate: date)
                        
            XCTAssert(dateComponents.weekday == 7)
            XCTAssert(dateComponents.day == 7)
            XCTAssert(dateComponents.month == 6)
            XCTAssert(dateComponents.year == 2014)
            XCTAssert(dateComponents.hour == 17)
            XCTAssert(dateComponents.minute == 04)
            XCTAssert(dateComponents.second == 37)
            XCTAssert(dateComponents.timeZone!.isEqualToTimeZone(GMT_timeZone))
            
            
        }
        else
        {
            XCTFail("date should not be nil")
        }
    }
}
