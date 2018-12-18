//
//  ApiManager.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 17/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation
import Alamofire

public typealias ApiManagerResponse = (AnyObject) -> Void
public typealias ApiManagerError = (NSError?) -> Void

class ApiManager {
    
    let BASE_URL = "https://en.wikipedia.org//w/"
    
    class var sharedInstance : ApiManager {
        struct Static {
            static let instance : ApiManager = ApiManager()
        }
        return Static.instance
    }
    
    
//    https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=Sachin+T&gpslimit=10
    

    func getSearchListWithSearchTerm(_ searchTerm: String, completion : @escaping ApiManagerResponse, errorHandler : @escaping ApiManagerError) {
        
        let url = "\(BASE_URL)api.php?action=query&format=json&prop=pageimages%7Cpageterms%7Cinfo&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=100&pilimit=10&wbptterms=description&gpssearch=\(searchTerm)"
    
        print(url)
        
        Alamofire.request(url, method: .get , parameters: nil, encoding: JSONEncoding.default , headers: [:])

            .responseJSON {
                (response) -> Void in
                switch response.result {
                case .success(let data):
                    if let _: AnyObject = data as AnyObject? {
                        completion(data as AnyObject)
                    }
                case .failure(let error):
                    let err : NSError = (error as NSError)
                    errorHandler(err);
                }
        }
    }
    
    
}
