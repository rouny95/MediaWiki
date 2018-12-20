//
//  UserDefaultUtil.swift
//  MediaWiki
//
//  Created by Raunak Choudhary on 19/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation

class UserDefaultUtil: NSObject {
    
    class var sharedInstance : UserDefaultUtil {
        struct Static {
            static let instance : UserDefaultUtil = UserDefaultUtil()
        }
        return Static.instance
    }
    
    /// Save User Visited Page history for last 10 count
    ///
    /// - Parameter history: WikiSearchResult Object
    func saveUserSearchHistory(_ history: WikiSearchResult) {
        
        let userDefault = UserDefaults.standard
        
        var savedHistoryList = self.fetchUserSearchHistory()
        if (savedHistoryList.contains { $0.pageId! == history.pageId!}) == false {
            if savedHistoryList.count >= 10 {
                savedHistoryList.removeLast()
                savedHistoryList.insert(history, at: 0)
            } else {
                savedHistoryList.insert(history, at: 0)
            }
            userDefault.removeObject(forKey: "mediWikiSeachHistory")
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: savedHistoryList)
            userDefault.set(archivedData, forKey: "mediWikiSeachHistory")
            userDefault.synchronize()
        }
    }
    
    /// Fetch the saved Seahced history
    ///
    /// - Returns: Returns array of WikiSearchResult
    func fetchUserSearchHistory() -> [WikiSearchResult] {
        
        let userDefault = UserDefaults.standard
        let historyData: Data? = userDefault.object(forKey: "mediWikiSeachHistory") as? Data
        
        if let history = historyData {
            let historyList = NSKeyedUnarchiver.unarchiveObject(with: history) as? [WikiSearchResult]
            if let historyArray = historyList {
                userDefault.removeObject(forKey: "mediWikiSeachHistory")
                let archivedData = NSKeyedArchiver.archivedData(withRootObject: historyArray)
                userDefault.set(archivedData, forKey: "mediWikiSeachHistory")
                userDefault.synchronize()
                return historyArray
            } else {
                return []
            }
        }
        return []
    }
}
