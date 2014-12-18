//
//  ArtistBioTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistBioTableViewCell: UITableViewCell {
    
    @IBOutlet var bioLabel: UILabel?
    
    class func heightForBio(bio: String) -> CGFloat
    {
        var prototypeCell = ArtistBioTableViewCell()
        return prototypeCell.heightForBio(bio)
    }

    func heightForBio(bio: String) -> CGFloat
    {
        
        let maxSize = CGSizeMake(self.frame.size.width - 20, 150)
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(13.0)]
        
        let size = bio.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        return size.height
    }

}
