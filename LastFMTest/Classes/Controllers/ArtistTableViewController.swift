//
//  ArtistTableViewController.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 17/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistTableViewController: UITableViewController {
    
    var artist: Artist?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let a = self.artist?
        {
            if let artistName = a.name?
            {
                self.title = artistName
            }
            
            LFMAPIClient.getInfoForArtist(a, callback: { (artist, error) -> Void in
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let artist = self.artist?
        {
            if indexPath.row == 0 // header
            {
                return 150
            }
            
            if indexPath.row == 1 // bio
            {
                if let bio = artist.bio
                {
                    if let content = bio.content
                    {
                        return ArtistBioTableViewCell.heightForBio(content)
                    }
                }
            }
        }
        return 0
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let artist = self.artist?
        {
            return 2
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        
        if indexPath.row == 0
        {
            cellIdentifier = "artistHeaderCell"
        }
        else if indexPath.row == 1
        {
            cellIdentifier = "artistBioCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell

        if let artist = self.artist?
        {
            if let c = cell as? ArtistHeaderTableViewCell
            {
                c.setArtist(artist)
            }
            else if let c = cell as? ArtistBioTableViewCell
            {
                if let label = c.bioLabel?
                {
                    if let bio = artist.bio?
                    {
                        if let bioContent = bio.content?
                        {
                            label.text = bioContent
                        }
                    }
                }
            }
        }

        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
