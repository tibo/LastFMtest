//
//  ArtistTagTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

let margin: CGFloat = 10.0
let padding: CGFloat = 3.0

class ArtistTagTableViewCell: UITableViewCell {

    class func heightForCellWithTags(tags: [Tag], constrainedToWidth: CGFloat) -> CGFloat
    {
        var prototype = ArtistTagTableViewCell()
        var frame = prototype.frame
        frame.size.width = constrainedToWidth
        prototype.frame = frame
        prototype.setTags(tags)
        
        var maxY: CGFloat = 0
        
        for v in prototype.contentView.subviews as [UIView]
        {
            if v is TagLabel
            {
                if maxY < (v.frame.origin.y + v.frame.size.height)
                {
                    maxY = (v.frame.origin.y + v.frame.size.height)
                }
            }
        }
        
        maxY += margin
        
        return maxY
    }
    
    func setTags(tags: [Tag])
    {
        var originX: CGFloat = margin
        var originY: CGFloat = margin
        
        for tag in tags
        {
            if let tagName = tag.name?
            {
                var label = TagLabel(frame: CGRectZero)
                label.text = tagName.lowercaseString
                
                label.sizeToFit()
                
                var frame = label.frame
                
                if (originX + frame.size.width) > (self.frame.width - margin)
                {
                    originX = margin
                    originY += label.frame.size.height + margin
                }
                
                frame.origin.x = originX
                frame.origin.y = originY
                frame.size.width += padding * 2
                frame.size.height += padding * 2
                
                label.frame = frame
                
                self.contentView.addSubview(label)
                
                originX += label.frame.size.width + margin
            }
        }
    }

}
