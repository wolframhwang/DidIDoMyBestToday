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
    
    func saveRealmData(data: RealmTaskData) {
        let model = RealmTaskData()
        model.title = data.title
        model.contents = data.contents
        model.satisfy = data.satisfy
        model.date = data.date
        
        try! realmInstance.write {
            realmInstance.add(model)
        }
    }
    
    
    func getRealmDataInfo(condition: String?) -> [TaskData] {
        var q: Results<RealmTaskData>? = nil
        
        if let condition = condition {
            q = realmInstance
                    .objects(RealmTaskData.self)
                    .filter(NSPredicate(format: "date = %@", condition))
            
        } else {
            q = realmInstance
                    .objects(RealmTaskData.self)
        }
        guard let q = q else { return [] }
        
        return q.map {
                    TaskData(title: $0.title,
                             contents: $0.contents,
                             satisfy: $0.satisfy,
                             date: $0.date)
            }
    }
    
    func removeAllRealmData() {
        try! realmInstance.write {
            realmInstance.deleteAll()
        }
    }
}
