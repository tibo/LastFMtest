//
//  SearchTableViewController.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 16/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var artists = [Artist]()
    @IBOutlet var searchBar: UISearchBar?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let searchBar = self.searchBar?
        {
            searchBar.accessibilityLabel = "artistSearchBar"
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.artists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("artistResultCell", forIndexPath: indexPath) as ArtistTableViewCell

        let artist = self.artists[indexPath.row]
        
        if let artistName = artist.name?
        {
            cell.accessibilityLabel = String("artist-cell-" + artistName)
            
            if let artistNameLabel = cell.artistNameLabel?
            {
                artistNameLabel.text = artistName
            }
        }
        
        if let imageURL = artist.thumbnailImageURL()?
        {
            if let artistImageView = cell.artistImageView?
            {
                artistImageView.hnk_setImageFromURL(imageURL)
            }
        }
        
        if let listeners = artist.listeners?
        {
            if let listenersLabel = cell.listenersLabel?
            {
                listenersLabel.text = "\(listeners) Listeners"
            }
        }

        return cell
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.artists = [Artist]()
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        
        if searchBar.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            return
        }
        
        LFMAPIClient.searchArtist(searchBar.text,
            callback: { (artists, error, haveNext) -> Void in
                if let wrappedError = error?
                {
                    var alert = UIAlertController(title: "Error", message: wrappedError.localizedDescription, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if let wrappedArtists = artists?
                {
                    self.artists = wrappedArtists
                    self.tableView.reloadData()
                }
        })
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier?
        {
            if identifier == "push_artist"
            {
                if let indexPath = self.tableView.indexPathForSelectedRow()
                {
                    let artistController = segue.destinationViewController as ArtistTableViewController
                    
                    artistController.artist = self.artists[indexPath.row]
                }
            }
        }
    }

}
