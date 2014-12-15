//
//  NSURL+urlBuilder.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 13/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

extension NSURL {
    
    class func URLWithBaseURL(url: String!, method: String!, params: [String: String]!) -> NSURL? {        
        var url_string = url + "?method=" + method
        
        for key in params.keys {
            if let val = params[key]
            {
                url_string += "&" + key + "=" + val
            }
        }
        
        url_string = url_string.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        return NSURL(string: url_string)
    }
    
    class func testURLForMethod(method: String!, params: [String: String]!) -> NSURL? {
        #if TESTING
            var filename = "artist.search-SalutCestCool.json"
            
            if let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil, inDirectory: nil)
            {
                return NSURL(fileURLWithPath: path)
            }
            
            return nil
        #else
            return nil
        #endif
    }
}