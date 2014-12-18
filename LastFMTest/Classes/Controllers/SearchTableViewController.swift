//
//  SearchTableViewController.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 16/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate, UIScrollViewDelegate {
    
    var artists = [Artist]()
    @IBOutlet var searchBar: UISearchBar?
    
    var searchText: String?
    var hasNext: Bool = false
    var nextPage: Int16 = 1
    
    var isLoading: Bool = false

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
        
        cell.setArtist(artist)

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
        
        self.searchText = searchBar.text
        
        self.artists = [Artist]()
        
        self.hasNext = true
        self.nextPage = 1

        self.loadResults()
    }
    
    // MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if scrollView == self.tableView
        {
            if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height
            {
                self.loadResults()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier?
        {
            if identifier == "push_artist"
            {
                if let indexPath = self.tableView.indexPathForSelectedRow()?
                {
                    let artistController = segue.destinationViewController as ArtistTableViewController
                    
                    artistController.artist = self.artists[indexPath.row]
                }
            }
        }
    }
    
    // MARK: - Loading
    func loadResults()
    {
        if !self.hasNext || self.isLoading
        {
            return
        }
        
        if let searchText = self.searchText?
        {
         
            self.isLoading = true
            LFMAPIClient.searchArtist(searchText, page: self.nextPage,
                callback: { (artists, error, haveNext) -> Void in
                    self.isLoading = false
                    if let wrappedError = error?
                    {
                        var alert = UIAlertController(title: "Error", message: wrappedError.localizedDescription, preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else if let wrappedArtists = artists?
                    {
                        if haveNext
                        {
                            self.hasNext = true
                            self.nextPage++
                        }
                        else
                        {
                            self.hasNext = false
                        }
                        
                        self.artists += wrappedArtists
                        self.tableView.reloadData()
                    }
            })
        }
    }

}
