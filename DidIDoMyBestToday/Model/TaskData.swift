//
//  TaskData.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation

struct TaskData {
    var id: Int = 0
    let title: String
    let contents: String
    let satisfy: Int
    let date: String
    init(id: Int, title: String, contents: String, satisfy: Int, date: String) {
        self.id = id
        self.title = title
        self.contents = contents
        self.satisfy = satisfy
        self.date = date
    }
    init(title: String, contents: String, satisfy: Int, date: String) {
        self.id = 0
        self.title = title
        self.contents = contents
        self.satisfy = satisfy
        self.date = date
    }
    func transRealmData() -> TaskObject {
        let realmData = TaskObject()
        realmData.idInfo = self.id
        realmData.title = self.title
        realmData.contents = self.contents
        realmData.satisfy = self.satisfy
        realmData.date = self.date
        return realmData
    }
}
