//
//  RealmData.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import RealmSwift

class TaskObject: Object {
    @objc dynamic var idInfo: Int = 0
    @objc dynamic var title = ""
    @objc dynamic var contents = ""
    @objc dynamic var satisfy: Int = Int()
    @objc dynamic var date: String = ""
    
    
}
