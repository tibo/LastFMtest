//
//  ArtistBio.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistBio: NSObject {
    
    var originalURL: NSURL?
    var publishDate: NSDate?
    var summary: String?
    var content: String?
   
    
    func fillWithDictionary(json: NSDictionary!)
    {
        if let links = json["links"] as? NSDictionary
        {
            if let link = links["link"] as? NSDictionary
            {
                if let rel = link["rel"] as? String
                {
                    if rel == "original"
                    {
                        if let href = link["href"] as? String
                        {
                            self.originalURL = NSURL(string: href)
                        }
                    }
                }
            }
        }
        
        if let published = json["published"] as? String
        {
            self.publishDate = NSDate.dateFromAPIDateString(published)
        }
        
        if let summary = json["summary"] as? String
        {
            self.summary = summary
        }
        
        if let content = json["content"] as? String
        {
            self.content = content
        }
    }
}
