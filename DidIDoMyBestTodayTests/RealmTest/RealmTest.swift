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
    
    func test_removeTest() {
        realm.removeAllRealmData()
    }
    
    func test_Insert() {
        realm.removeAllRealmData()

        let data1 = TaskObject()
        let data2 = TaskObject()
        let data3 = TaskObject()
        let data4 = TaskObject()
        data1.title = "Data1"
        data1.contents = "CData1"
        data1.satisfy = 0
        data1.date = "2022-06-12"

        data2.title = "Data2"
        data2.contents = "CData2"
        data2.satisfy = 0
        data2.date = "2022-06-12"

        data3.title = "Data3"
        data3.contents = "CData3"
        data3.satisfy = 0
        data3.date = "2022-06-12"

        data4.title = "Data4"
        data4.contents = "CData4"
        data4.satisfy = 0
        data4.date = "2022-06-12"


        var data = realm.getRealmDataInfo(condition: nil)
        print(data)
        
        XCTAssertEqual(realm.getRealmDataInfo(condition: nil).count, 0)
        realm.saveRealmData(data: data1)
        realm.saveRealmData(data: data2)
        realm.saveRealmData(data: data3)
        realm.saveRealmData(data: data4)
        
        data = realm.getRealmDataInfo(condition: nil)
        print(data)
        XCTAssertEqual(realm.getRealmDataInfo(condition: nil).count, 4)
        XCTAssertEqual(realm.getRealmDataInfo(condition: "2022-06-12").count, 4)
    }
    
    func test_Remove() {
        
    }
    
    func test_Query() {
        
    }
}
