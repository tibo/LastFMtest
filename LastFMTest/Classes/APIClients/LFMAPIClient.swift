//
//  LFMAPIClient.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 13/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

private let _sharedClient = LFMAPIClient()

class LFMAPIClient: NSObject {
    
    private let api_key = "57b5a22d4a903735457999270a03664c"
    private let baseURL = "http://ws.audioscrobbler.com/2.0/"
    
    class var sharedClient : LFMAPIClient {
        return _sharedClient
    }
    
    func getMethod(method: String!, parameters: [String: String]!, callback: (results: AnyObject?, error: NSError?) -> Void)
    {
        var params = parameters
        params["api_key"] = api_key
        params["format"] = "json"
        
        if let url = NSURL.URLWithBaseURL(baseURL, method: method, params: params)?
        {
            let request = NSURLRequest(URL: url)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                let results: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                
                callback(results: results, error: error)
            })
        }
        
    }
    
    class func searchArtist(artistSearch: String, callback: (artists: [String]?, error: NSError?) -> Void)
    {
        var params = ["artist" : artistSearch]
        
        LFMAPIClient.sharedClient.getMethod("artist.search", parameters: params) { (results, error) -> Void in
            
            NSLog("\(results)")
            
            callback(artists: nil, error: error)
            
        }
    }
}
