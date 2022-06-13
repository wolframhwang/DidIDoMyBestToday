//
//  TaskData.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation

struct TaskData {
    let title: String
    let contents: String
    let satisfy: Int
    let date: String
    
    func transRealmData() -> RealmTaskData {
        let realmData = RealmTaskData()
        realmData.title = self.title
        realmData.contents = self.contents
        realmData.satisfy = self.satisfy
        realmData.date = self.date
        return realmData
    }
}
