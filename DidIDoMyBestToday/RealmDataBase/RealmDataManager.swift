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
        
    func saveRealmData(data: TaskObject) {
        let model = TaskObject()
        let id = UserDefaults.standard.integer(forKey: "modelID")
        model.idInfo = id
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
    
    func updateRealmDataInfo(data: TaskObject) {
        let id = data.idInfo
        print("FCK")
        print(data, id)
        if let realmData = realmInstance
            .objects(TaskObject.self)
            .filter(NSPredicate(format: "idInfo = %i", id)).first {
            do {
                try! realmInstance.write {
                    realmData.title = data.title
                    realmData.contents = data.contents
                    realmData.satisfy = data.satisfy
                }
            } catch (let e) {
                print(e)
            }
        }
    }
    
    func getRealmDataInfo(condition: String?) -> [TaskData] {
        var q: Results<TaskObject>? = nil
        
        if let condition = condition {
            q = realmInstance
                    .objects(TaskObject.self)
                    .filter(NSPredicate(format: "date = %@", condition))
            
        } else {
            q = realmInstance
                    .objects(TaskObject.self)
        }
        guard let q = q else { return [] }
        
        return q.map {
            return TaskData(id: $0.idInfo,
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
