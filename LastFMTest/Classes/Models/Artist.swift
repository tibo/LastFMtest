//
//  Artist.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 15/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class Artist: NSObject {
    var name: String?
    var listeners: Int64?
    var mbid: String?
    var url: NSURL?
    var images: [String : NSURL]?
    
    func fillWithDictionary(json: NSDictionary!)
    {
        if let name = json["name"] as? String
        {
            self.name = name
        }
        
        if let listeners = json["listeners"] as? String
        {
            self.listeners = Int64(listeners.toInt()!)
        }
        
        if let mbid = json["mbid"] as? String
        {
            self.mbid = mbid
        }
        
        if let url = json["url"] as? String
        {
            self.url = NSURL(string: url)
        }
        
        if let images = json["image"] as? [[String : String]]
        {
            self.images = [String : NSURL]()
            
            for image in images
            {
                if let urlString = image["#text"]?
                {
                    let url = NSURL(string: urlString)
                    if let size = image["size"]?
                    {
                        self.images![size] = url
                    }
                }
            }
        }
    }
}