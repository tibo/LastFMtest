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
    
    func fillWithDictionary(json: NSDictionary!)
    {
        if let name = json["name"] as? String
        {
            self.name = name
        }
    }
}
