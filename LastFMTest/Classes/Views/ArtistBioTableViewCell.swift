//
//  ArtistBioTableViewCell.swift
//  LastFMTest
//
//  Created by Thibaut LE LEVIER on 18/12/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

class ArtistBioTableViewCell: UITableViewCell {
    
    @IBOutlet var bioLabel: UILabel?
    
    override func awakeFromNib() {
        if let label = self.bioLabel?
        {
            label.text = nil
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.adjustsFontSizeToFitWidth = true
        }
    }
    
    class func heightForCellWithBio(bio: String, constrainedToWidth: CGFloat) -> CGFloat
    {
        if countElements(bio) == 0
        {
            return 0
        }
        
        let maxSize = CGSizeMake(constrainedToWidth - 20, CGFloat.max)
        
        // may not work well... because Swift: http://stackoverflow.com/questions/24064650/how-to-pass-multiple-enum-values-as-a-function-parameter
        let size = bio.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], context: nil).size
        
        return size.height
    }
    
    func setBio(bio: String)
    {
        if let label = self.bioLabel?
        {
            if let htmlData = bio.dataUsingEncoding(NSUTF8StringEncoding)?
            {
                var attributes = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName: UIFont.systemFontOfSize(15)]
                
                var error: NSError?
                label.attributedText = NSAttributedString(data: htmlData,
                    options: attributes,
                    documentAttributes: nil,
                    error: &error)
            }
            
            
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
