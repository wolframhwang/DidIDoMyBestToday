//
//  RealmDataManager.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import RealmSwift

class RealmDataManager {
    let realmInstance = try! Realm()
    
    func saveRealmData(data: RealmData) {
        let model = RealmData()
        model.title = data.title
        model.contents = data.contents
        model.satisfy = data.satisfy
        model.date = data.date
        
        try! realmInstance.write {
            realmInstance.add(model)
        }
    }
    
    
    func getRealmDataInfo(condition: Date?) -> NSArray {
        return NSArray(array: Array(realmInstance.objects(RealmData.self)))        
    }
}
