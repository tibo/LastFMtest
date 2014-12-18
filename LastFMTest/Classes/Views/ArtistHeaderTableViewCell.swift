//
//  ArtistHeaderTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistHeaderTableViewCell: UITableViewCell {
    
    var artist: Artist?
    
    @IBOutlet var artistImageView: UIImageView?
    @IBOutlet var listenersLegendLabel: UILabel?
    @IBOutlet var listenersLabel: UILabel?
    @IBOutlet var playCountLegendLabel: UILabel?
    @IBOutlet var playCountLabel: UILabel?
    
    func setArtist(a: Artist!)
    {
        self.artist = a
        
        self._refreshContent()
    }
    
    func _refreshContent()
    {
        if let artist = self.artist?
        {
            if let image = artist.biggerImageURL()?
            {
                if let imageView = self.artistImageView?
                {
                    imageView.hnk_setImageFromURL(image)
                }
            }
            
            if let listeners = artist.listeners?
            {
                if let label = self.listenersLabel?
                {
                    label.text = "\(listeners)"
                    label.hidden = false
                }
                
                if let label = self.listenersLegendLabel?
                {
                    label.hidden = false
                }
            }
            else
            {
                if let label = self.listenersLegendLabel?
                {
                    label.hidden = true
                }
                
                if let label = self.listenersLabel?
                {
                    label.hidden = true
                }
            }
            
            if let playCount = artist.playcount?
            {
                if let label = self.playCountLabel?
                {
                    label.text = "\(playCount)"
                    label.hidden = false
                }
                
                if let label = self.playCountLegendLabel?
                {
                    label.hidden = false
                }
            }
            else
            {
                if let label = self.playCountLegendLabel?
                {
                    label.hidden = true
                }
                
                if let label = self.playCountLabel?
                {
                    label.hidden = true
                }
            }
        }
    }
}
