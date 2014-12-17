//
//  UITests.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 16/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class UITests: KIFTestCase {
    var tester : KIFUITestActor {
        get {
            return KIFUITestActor(inFile: __FILE__, atLine: __LINE__, delegate: self)
        }
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_basicSearch() {
        tester.waitForViewWithAccessibilityLabel("artistSearchBar")
        tester.enterText("cher", intoViewWithAccessibilityLabel: "artistSearchBar")
        tester.tapViewWithAccessibilityLabel("search")
        tester.waitForAbsenceOfSoftwareKeyboard()
        tester.waitForViewWithAccessibilityLabel("artist-Cher")
    }

}
