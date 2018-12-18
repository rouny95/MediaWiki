//
//  WikiSearchResult.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 17/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation

struct WikiSearchResult {
    
    var pageId: Int?
    var title: String?
    var thumbnailUrl: String?
    var wikiPageUrl: String?
    var description = [String]()
    
    
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
        
        if let terms = dictionary.object(forKey: "terms") {
            self.description = []
            let descriptions: NSArray = (terms as AnyObject).object(forKey: "description")  as! NSArray
            for eachDescription in descriptions {
                let descriptionObj = eachDescription as! String
                self.description.append(descriptionObj)
            }
        }
    }
    
}
