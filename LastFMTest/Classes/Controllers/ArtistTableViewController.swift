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
            })
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier = "artistHeaderCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as ArtistHeaderTableViewCell

        if let artist = self.artist?
        {
            cell.setArtist(artist)
        }

        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}
