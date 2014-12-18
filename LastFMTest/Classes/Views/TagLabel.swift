//
//  TagLabel.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import QuartzCore

class TagLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 1/255.0, green: 121/255.0, blue: 177/255.0, alpha: 1.0)
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.boldSystemFontOfSize(13)
        self.textAlignment = NSTextAlignment.Center
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        self.layer.shadowColor = UIColor.blueColor().CGColor
        self.shadowOffset = CGSizeMake(1, 1)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


