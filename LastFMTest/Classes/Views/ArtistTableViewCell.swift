//
//  ArtistTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet var artistNameLabel: UILabel?
    @IBOutlet var artistImageView: UIImageView?
    @IBOutlet var listenersLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareForReuse() // call prepare for reuse to reset default labels
    }
    
    override func prepareForReuse() {
        
        if let artistNameLabel = self.artistNameLabel?
        {
            artistNameLabel.text = nil
        }
        
        if let artistImageView = self.artistImageView?
        {
            artistImageView.image = nil
        }
        
        if let listenersLabel = self.listenersLabel?
        {
            listenersLabel.text = nil
        }
    }

    func setArtist(artist: Artist!)
    {
        if let artistName = artist.name?
        {
            self.accessibilityLabel = String("artist-cell-" + artistName)
            
            if let artistNameLabel = self.artistNameLabel?
            {
                artistNameLabel.text = artistName
            }
        }
        
        if let imageURL = artist.thumbnailImageURL()?
        {
            if let artistImageView = self.artistImageView?
            {
                artistImageView.clipsToBounds = true
                artistImageView.sd_setImageWithURL(imageURL)
            }
        }
        
        if let listeners = artist.listeners?
        {
            if let listenersLabel = self.listenersLabel?
            {
                listenersLabel.text = "\(listeners) Listeners"
            }
        }
    }

}
