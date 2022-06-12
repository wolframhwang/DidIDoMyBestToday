//
//  RealmTest.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/12.
//

import XCTest
@testable import DidIDoMyBestToday

class RealmTest: XCTestCase {
    let realm = RealmDataManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Insert() {
        let data1 = RealmData()
        let data2 = RealmData()
        let data3 = RealmData()
        let data4 = RealmData()
        data1.title = "Data1"
        data1.contents = "CData1"
        data1.satisfy = 3
        data1.date = Date()
        
        data2.title = "Data2"
        data2.contents = "CData2"
        data2.satisfy = 4
        data2.date = Date()
        
        data3.title = "Data3"
        data3.contents = "CData3"
        data3.satisfy = 5
        data3.date = Date()
        
        data4.title = "Data4"
        data4.contents = "CData4"
        data4.satisfy = 1
        data4.date = Date()
        

        let data = realm.getRealmDataInfo(condition: nil)
        print(data)
        XCTAssertEqual(realm.getRealmDataInfo(condition: nil).count, 4)
        realm.saveRealmData(data: data1)
        realm.saveRealmData(data: data2)
        realm.saveRealmData(data: data3)
        realm.saveRealmData(data: data4)
        
        XCTAssertEqual(realm.getRealmDataInfo(condition: nil).count, 8)
        
    }
    
    func test_Remove() {
        
    }
    
    func test_Query() {
        
    }
}
