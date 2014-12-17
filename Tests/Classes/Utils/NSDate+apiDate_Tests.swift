//
//  NSDate+apiDate_Tests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class NSDate_apiDate_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_dateFromAPIDateString_withValidDateString_shouldReturnValidDate() {
        if let date = NSDate.dateFromAPIDateString("Sat, 7 Jun 2014 17:04:37 +0000")
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
