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
    
    // MARK: config constants
    private let api_key = "57b5a22d4a903735457999270a03664c"
    private let baseURL = "http://ws.audioscrobbler.com/2.0/"
    
    // MARK: client instance
    class var sharedClient : LFMAPIClient {
        return _sharedClient
    }
    
    // MARK: generic calls
    func getMethod(method: String!, parameters: [String: String]!, page: Int16, callback: (result: AnyObject?, error: NSError?, haveNext: Bool) -> Void)
    {
        var params = parameters
        params["api_key"] = api_key
        params["format"] = "json"
        params["page"] = String(page)
        
        var url: NSURL?
        
        #if TESTING
            url = NSURL.testURLForMethod(method, params: params)
        #else
            url = NSURL.URLWithBaseURL(baseURL, method: method, params: params)
        #endif

        if let u = url?
        {
            let request = NSURLRequest(URL: u)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                var parsingError: NSError?
                
                let unwrappedReturn: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                
                if let error = parsingError?
                {
                    println("Parsing Error: \(error)")
                }
                
                // calcul if have next
                var haveNext = false
                
                if let wrappedReturn = unwrappedReturn as? NSDictionary
                {
                    if let results = wrappedReturn["results"] as? NSDictionary
                    {
                        if let totalResults = results["opensearch:totalResults"] as? String
                        {
                            if let startIndex = results["opensearch:startIndex"] as? String
                            {
                                var itemsPerPage  = 30 // default value according to the API documentation
                                
                                if let itemsPage = results["opensearch:itemsPerPage"] as? String
                                {
                                    itemsPerPage = itemsPage.toInt()!
                                }
                                
                                let totalRes = totalResults.toInt()!
                                let startIdx = startIndex.toInt()!
                                
                                let itemsRemaining = totalRes - (itemsPerPage + startIdx)
                                
                                if itemsRemaining > 0
                                {
                                    haveNext = true
                                }
                            }
                            
                        }
                    }
                }
                
                
                callback(result: unwrappedReturn, error: error, haveNext: haveNext)
            })
        }
        
    }
    
    // MARK: search artist
    class func searchArtist(artistSearch: String, callback: (artists: [Artist]?, error: NSError?, haveNext: Bool) -> Void)
    {
        LFMAPIClient.searchArtist(artistSearch, page: 1, callback: callback)
    }
    
    class func searchArtist(artistSearch: String, page: Int16, callback: (artists: [Artist]?, error: NSError?, haveNext: Bool) -> Void)
    {
        var params = ["artist" : artistSearch]
        
        LFMAPIClient.sharedClient.getMethod("artist.search", parameters: params, page: page) { (result, error, haveNext) -> Void in
            
            var artistsArray: [Artist]?
            
            if let wrappedResult = result as NSDictionary?
            {
                if let results = wrappedResult["results"] as NSDictionary?
                {
                    if let matches = results["artistmatches"] as NSDictionary?
                    {
                        if let artists: AnyObject = matches["artist"]?
                        {
                            
                            if artists is NSDictionary
                            {
                                var artist = Artist()
                                artist.fillWithDictionary(artists as NSDictionary)
                                
                                artistsArray = [artist]
                            }
                            else if artists is NSArray
                            {
                                artistsArray = [Artist]()
                                
                                for a in (artists as NSArray)
                                {
                                    var artist = Artist()
                                    artist.fillWithDictionary(a as NSDictionary)
                                    
                                    artistsArray!.append(artist)
                                }
                                
                            }
                        }
                    }
                }
            }
            
            callback(artists: artistsArray, error: error, haveNext: haveNext)
            
        }
    }
}
