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
    
    func saveUserSearchHistory(_ history: WikiSearchResult) {
        
        let userDefault = UserDefaults.standard
        // let savedHistory = userDefault.object(forKey: "mediWikiSeachHistory") as? Data
        
        //        if let savedHis = savedHistory {
        //            var hsitoryArray = NSKeyedUnarchiver.unarchiveObject(with: savedHis) as? [WikiSearchResult]
        //            hsitoryArray?.append(history)
        //            userDefault.removeObject(forKey: "mediWikiSeachHistory")
        //            let archivedData = NSKeyedArchiver.archivedData(withRootObject: hsitoryArray!)
        //            userDefault.set(archivedData, forKey: "mediWikiSeachHistory")
        //            userDefault.synchronize()
        //        } else {
        //            var hsitoryArray = [WikiSearchResult]()
        //            hsitoryArray.append(history)
        //            userDefault.removeObject(forKey: "mediWikiSeachHistory")
        //            let archivedData = NSKeyedArchiver.archivedData(withRootObject: hsitoryArray)
        //            userDefault.set(archivedData, forKey: "mediWikiSeachHistory")
        //            userDefault.synchronize()
        //        }
        
        var savedHistoryList = self.fetchUserSearchHistory()
        if savedHistoryList.count >= 10 {
            savedHistoryList.removeLast()
            savedHistoryList.append(history)
        } else {
            savedHistoryList.append(history)
        }
        userDefault.removeObject(forKey: "mediWikiSeachHistory")
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: savedHistoryList)
        userDefault.set(archivedData, forKey: "mediWikiSeachHistory")
        userDefault.synchronize()
    }
    
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
