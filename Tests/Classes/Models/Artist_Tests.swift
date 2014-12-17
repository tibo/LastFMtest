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
        
        XCTAssert(artist.name == "Salut C'est Cool")
        XCTAssert(artist.listeners == 940664)
        XCTAssert(artist.mbid == "70c0cd8b-a942-4b8f-b421-b2b5218e23b6")
        XCTAssertFalse(artist.streamable)
        
        if let url = artist.url?
        {
            XCTAssert(url.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool")
        }
        else
        {
            XCTFail("url should not be nil")
        }
        
        if let images = artist.images?
        {
            if let img = images["small"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/34/95960219.jpg")
            }
            else
            {
                XCTFail("should have small image")
            }
            
            if let img = images["medium"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/64/95960219.jpg")
            }
            else
            {
                XCTFail("should have medium image")
            }
            
            if let img = images["large"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/126/95960219.jpg")
            }
            else
            {
                XCTFail("should have large image")
            }
            
            if let img = images["extralarge"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/252/95960219.jpg")
            }
            else
            {
                XCTFail("should have extralarge image")
            }
            
            if let img = images["mega"]
            {
                XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/500/95960219/Salut+Cest+Cool+salut.jpg")
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
    
    func test_fillWithDictionary_withJSONFromGetInfo_shouldReturnRightValues()
    {
        let mock_path = NSBundle.mainBundle().pathForResource("artist.getinfo-70c0cd8b-a942-4b8f-b421-b2b5218e23b6.json", ofType: nil, inDirectory: nil)
        let mock_getInfo = NSData.dataWithContentsOfMappedFile(mock_path!) as NSData
        var parsingError: NSError?
        let json_getInfo = NSJSONSerialization.JSONObjectWithData(mock_getInfo, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as NSDictionary
        
        if let mock2 = json_getInfo["artist"] as? NSDictionary
        {
        
            var artist = Artist()
            artist.fillWithDictionary(mock2)
            
            XCTAssert(artist.name == "Salut C'est Cool")
            XCTAssert(artist.listeners == 790)
            XCTAssert(artist.mbid == "70c0cd8b-a942-4b8f-b421-b2b5218e23b6")
            XCTAssertFalse(artist.onTour)
            XCTAssertFalse(artist.streamable)
            
            if let url = artist.url?
            {
                XCTAssert(url.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool")
            }
            else
            {
                XCTFail("url should not be nil")
            }
            
            if let images = artist.images?
            {
                if let img = images["small"]
                {
                    XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/34/95960219.jpg")
                }
                else
                {
                    XCTFail("should have small image")
                }
                
                if let img = images["medium"]
                {
                    XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/64/95960219.jpg")
                }
                else
                {
                    XCTFail("should have medium image")
                }
                
                if let img = images["large"]
                {
                    XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/126/95960219.jpg")
                }
                else
                {
                    XCTFail("should have large image")
                }
                
                if let img = images["extralarge"]
                {
                    XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/252/95960219.jpg")
                }
                else
                {
                    XCTFail("should have extralarge image")
                }
                
                if let img = images["mega"]
                {
                    XCTAssert(img.absoluteString == "http://userserve-ak.last.fm/serve/500/95960219/Salut+Cest+Cool+salut.jpg")
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
            
            XCTAssert(artist.playcount == 28545)
            
            if let similars = artist.similars?
            {
                XCTAssert(similars.count == 5)
                XCTAssert(similars[0].name! == "Club Cheval")
                XCTAssert(similars[0].url!.absoluteString == "http://www.last.fm/music/Club+Cheval")
                XCTAssert(similars[0].images!["mega"]!.absoluteString == "http://userserve-ak.last.fm/serve/500/78651966/Club+Cheval+clubcheval_color.jpg")
            }
            else
            {
                XCTFail("should have similars")
            }
            
            if let tags = artist.tags?
            {
                XCTAssert(tags.count == 5)
                XCTAssert(tags[0].name! == "house")
                XCTAssert(tags[0].url!.absoluteString == "http://www.last.fm/tag/house")
            }
            else
            {
                XCTFail("should have tags")
            }
            
            if let bio = artist.bio?
            {
                XCTAssert(bio.originalURL!.absoluteString == "http://www.last.fm/music/Salut+C%27est+Cool/+wiki")
                XCTAssert(bio.content! == "\n                    En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    \nUser-contributed text is available under the Creative Commons By-SA License and may also be available under the GNU FDL.\n    ")
                XCTAssert(bio.summary! == "\n                En 2010 quelqu'un a dit &quot;salut c'est cool&quot;.\n Salut c'est cool était né.  <a href=\"http://www.salutcestcool.com/\" rel=\"nofollow\">http://www.salutcestcool.com/</a>\n\n        <a href=\"http://www.last.fm/music/Salut+C%27est+Cool\">Read more about Salut C'est Cool on Last.fm</a>.\n    \n    ")
                
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
            else
            {
                XCTFail("should have bio")
            }
        }
        else
        {
            XCTFail("mock2 should not be nil")
        }
    }

}
