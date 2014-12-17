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
    var streamable: Bool = false
    
    // values from getInfo
    var playcount: Int64?
    var onTour: Bool = false
    var similars: [Artist]?
    var tags: [Tag]?
    var bio: ArtistBio?
    
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
        
        if let streamable = json["streamable"] as? String
        {
            self.streamable = (streamable.toInt()! == 1)
        }
        
        // values from getInfo
        if let onTour = json["ontour"] as? String
        {
            self.onTour = (onTour.toInt()! == 1)
        }
        
        if let stats = json["stats"] as? NSDictionary
        {
            if let listeners = stats["listeners"] as? String
            {
                self.listeners = Int64(listeners.toInt()!)
            }
            
            if let playcount = stats["playcount"] as? String
            {
                self.playcount = Int64(playcount.toInt()!)
            }
        }
        
        if let similars = json["similar"] as? NSDictionary
        {
            if let similarArtists = similars["artist"] as? NSArray
            {
                var artists = [Artist]()
                
                for a in similarArtists
                {
                    var artist = Artist()
                    artist.fillWithDictionary(a as NSDictionary)
                    
                    artists.append(artist)
                }
                
                self.similars = artists
            }
        }
        
        if let tags = json["tags"] as? NSDictionary
        {
            if let tagArray = tags["tag"] as? NSArray
            {
                var tags = [Tag]()
                
                for t in tagArray
                {
                    var tag = Tag()
                    tag.fillWithDictionary(t as NSDictionary)
                    
                    tags.append(tag)
                }
                
                self.tags = tags
            }
        }
        
        if let bio = json["bio"] as? NSDictionary
        {
            self.bio = ArtistBio()
            
            if let b = self.bio?
            {
                b.fillWithDictionary(bio)
            }
        }
    }
    
    func thumbnailImageURL() -> NSURL?
    {
        if let images = self.images?
        {
            if let url = images["large"]?
            {
                return url
            }
            
            if let url = images["extralarge"]?
            {
                return url
            }
            
            if let url = images["mega"]?
            {
                return url
            }
        }
        
        return nil
    }
}