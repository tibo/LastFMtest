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
    
    let headerIndex = 0
    let tagsIndex = 1
    let bioIndex = 2
    let similarFirstIndex = 3

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
            if indexPath.row == headerIndex
            {
                return 150
            }
            
            if indexPath.row == tagsIndex
            {
                if let tags = artist.tags?
                {
                    return ArtistTagTableViewCell.heightForCellWithTags(tags, constrainedToWidth: self.tableView.frame.width)
                }
            }
            
            if indexPath.row == bioIndex
            {
                if let bio = artist.bio?
                {
                    if let content = bio.content?
                    {
                        return ArtistBioTableViewCell.heightForCellWithBio(content, constrainedToWidth: self.tableView.frame.width)
                    }
                }
            }
        }
        return 80
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let artist = self.artist?
        {
            var rownNum = 3
            
            if let similars = artist.similars?
            {
                rownNum += similars.count
            }
            
            return rownNum
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        
        if indexPath.row == headerIndex
        {
            cellIdentifier = "artistHeaderCell"
        }
        else if indexPath.row == tagsIndex
        {
            cellIdentifier = "tagsCell"
        }
        else if indexPath.row == bioIndex
        {
            cellIdentifier = "artistBioCell"
        }
        else
        {
            if let artist = self.artist?
            {
                if let similars = artist.similars?
                {
                    if indexPath.row >= similarFirstIndex && indexPath.row < (similarFirstIndex + similars.count)
                    {
                        cellIdentifier = "artistResultCell"
                    }
                }
            }
            else
            {
                // just to prevent crashes. should not happens
                return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "errorCell")
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell

        if let artist = self.artist?
        {
            if let c = cell as? ArtistHeaderTableViewCell
            {
                c.setArtist(artist)
            }
            else if let c = cell as? ArtistTagTableViewCell
            {
                if let tags = artist.tags?
                {
                    c.setTags(tags)
                }
            }
            else if let c = cell as? ArtistBioTableViewCell
            {
               if let bio = artist.bio?
                {
                    if let bioContent = bio.content?
                    {
                        c.setBio(bioContent)
                    }
                }
            }
            else if let c = cell as? ArtistTableViewCell
            {
                if let similars = artist.similars?
                {
                    let similarArtist = similars[indexPath.row - similarFirstIndex]
                    
                    c.setArtist(similarArtist)
                }
            }
        }

        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier?
        {
            if identifier == "push_similar"
            {
                if let indexPath = self.tableView.indexPathForSelectedRow()?
                {
                    if let artist = self.artist?
                    {
                        if let similars = artist.similars?
                        {
                            let artistController = segue.destinationViewController as ArtistTableViewController
                            
                            artistController.artist = similars[indexPath.row - similarFirstIndex]
                        }
                    }
                    
                    
                    
                }
            }
        }

    }

}
