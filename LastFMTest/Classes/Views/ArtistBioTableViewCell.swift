//
//  ArtistBioTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class ArtistBioTableViewCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet var bioWebView: UIWebView?
    
    class func heightForCellWithBio(bio: String, constrainedToWidth: CGFloat) -> CGFloat
    {
        if countElements(bio) == 0
        {
            return 0
        }
//        =>  Prototype on webview doesn't work
//        
//        var prototypeCell = ArtistBioTableViewCell()
//        var frame = prototypeCell.frame
//        frame.size.width = constrainedToWidth
//        prototypeCell.frame = frame
//        if let webView = prototypeCell.bioWebView?
//        {
//            webView.loadHTMLString(bio, baseURL: nil)
//            
//            if let height = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight")?
//            {
//                return CGFloat((height as NSString).floatValue)
//            }
//            
//        }
//
//        => Use size calculated from String instead
        
        let maxSize = CGSizeMake(constrainedToWidth - 20, 150)
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(13.0)]
        
        let size = bio.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        return size.height
        
        
    }
    
    func setBio(bio: String)
    {
        if let webview = self.bioWebView?
        {
            webview.scrollView.scrollEnabled = false
            webview.loadHTMLString(bio, baseURL: nil)
        }
    }
    
    // MARK: UIWebViewDelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL.absoluteString == "about:blank"
        {
            return true
        }
        
        return false
    }

}
