//
//  WikiSearchResult.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 17/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation

class WikiSearchResult: NSObject, NSCoding {
    
    var pageId: Int?
    var title: String?
    var thumbnailUrl: String?
    var wikiPageUrl: String?
    var wikieDescription: String?
    
    
    init?(dictionary : NSDictionary) {
        
        if let _ = dictionary.object(forKey: "pageid") {
            self.pageId = (dictionary.object(forKey: "pageid") as? Int)!
        }
        
        if let _ = dictionary.object(forKey: "title") {
            self.title = (dictionary.object(forKey: "title") as! String)
        }
        
        if let thumbnail = dictionary.object(forKey: "thumbnail"), let _ = (thumbnail as AnyObject).object(forKey: "source") {
            self.thumbnailUrl = ((thumbnail as AnyObject).object(forKey: "source") as! String)
        }
        
        if let _ = dictionary.object(forKey: "fullurl") {
            self.wikiPageUrl = (dictionary.object(forKey: "fullurl") as! String)
        }
//        if let terms = dictionary.object(forKey: "terms") {
//            self.wikieDescription = []
//            let descriptions: NSArray = (terms as AnyObject).object(forKey: "description")  as! NSArray
//            for eachDescription in descriptions {
//                let descriptionObj = eachDescription as! String
//                self.wikieDescription.append(descriptionObj)
//            }
//        }
        
        if let terms = dictionary.object(forKey: "terms") {
            let descriptions: NSArray = (terms as AnyObject).object(forKey: "description")  as! NSArray
            if descriptions.count > 0 {
                self.wikieDescription = (descriptions[0] as! String)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.pageId = aDecoder.decodeInteger(forKey: "pageId")
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)
        self.thumbnailUrl = (aDecoder.decodeObject(forKey: "thumbnailUrl") as? String)
        self.wikiPageUrl = (aDecoder.decodeObject(forKey: "wikiPageUrl") as? String)
        self.wikieDescription = (aDecoder.decodeObject(forKey: "wikieDescription") as? String)
    }
    
    public func encode(with encoder: NSCoder) {
        
        if let pageId = self.pageId {
            encoder.encode(pageId, forKey: "pageId")
        }
        if let title = self.title {
            encoder.encode(title, forKey: "title")
        }
        if let thumbnailUrl = self.thumbnailUrl {
            encoder.encode(thumbnailUrl, forKey: "thumbnailUrl")
        }
        if let wikiPageUrl = self.wikiPageUrl {
            encoder.encode(wikiPageUrl, forKey: "wikiPageUrl")
        }
        if let wikieDescription = self.wikieDescription {
            encoder.encode(wikieDescription, forKey: "wikieDescription")
        }
    }
    
}
