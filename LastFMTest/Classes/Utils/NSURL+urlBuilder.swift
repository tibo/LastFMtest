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
            println("test mock url for method: \(method) and params: \(params)")
            
            var filename = ""
            
            if method == "artist.search"
            {
                if params["artist"] == "Salut C'est Cool"
                {
                    filename = "artist.search-SalutCestCool.json"
                }
                else if params["artist"] == "Salut"
                {
                    filename = "artist.search-Salut-page1.json"
            
                    if let pageString = params["page"]?
                    {
                        filename = "artist.search-Salut-page" + pageString + ".json"
                    }
            
                }
            }
            else if method == "artist.getinfo"
            {
                if let mbid = params["mbid"]
                {
                    if mbid == "70c0cd8b-a942-4b8f-b421-b2b5218e23b6"
                    {
                        filename = "artist.getinfo-70c0cd8b-a942-4b8f-b421-b2b5218e23b6.json"
                    }
                }
            
                if let artistName = params["artist"]
                {
                    if artistName == "Cher"
                    {
                        filename = "artist.getinfo-Cher.json"
                    }
                }
            }
            
            println("mock file: \(filename)")
            
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
