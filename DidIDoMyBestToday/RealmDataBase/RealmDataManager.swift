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
        
    func saveRealmData(data: RealmTaskObject) {
        let model = RealmTaskObject()
        let id = UserDefaults.standard.integer(forKey: "modelID")
        model.id = id
        UserDefaults.standard.set(id + 1, forKey: "modelID")
        
        model.title = data.title
        model.contents = data.contents
        model.satisfy = data.satisfy
        model.date = data.date
        print(model, "MODEL")
        try! realmInstance.write {
            realmInstance.add(model)
        }
    }
    
    
    func getRealmDataInfo(condition: String?) -> [TaskData] {
        var q: Results<RealmTaskObject>? = nil
        
        if let condition = condition {
            q = realmInstance
                    .objects(RealmTaskObject.self)
                    .filter(NSPredicate(format: "date = %@", condition))
            
        } else {
            q = realmInstance
                    .objects(RealmTaskObject.self)
        }
        guard let q = q else { return [] }
        
        return q.map {
            return TaskData(id: $0.id,
                            title: $0.title,
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
