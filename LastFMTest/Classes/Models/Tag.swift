//
//  Tag.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class Tag: NSObject {
    
    var name: String?
    var url: NSURL?
    
    func fillWithDictionary(json: NSDictionary!)
    {
        if let name = json["name"] as? String
        {
            self.name = name
        }
        
        if let url = json["url"] as? String
        {
            self.url = NSURL(string: url)
        }
    }
}
