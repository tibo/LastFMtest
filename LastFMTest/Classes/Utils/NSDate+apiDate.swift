//
//  NSDate+apiDate.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

extension NSDate {
    
    class var apiDateFormatter : NSDateFormatter {
        struct Static {
            static let instance: NSDateFormatter = {
                let dateFormatter = NSDateFormatter()
                let locale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")
                dateFormatter.locale = locale
                dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
                return dateFormatter
            }()
        }
        return Static.instance
    }
    
    class func dateFromAPIDateString(dateString: String!) -> NSDate?
    {
        return NSDate.apiDateFormatter.dateFromString(dateString)
    }
   
}
