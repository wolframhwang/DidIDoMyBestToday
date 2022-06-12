//
//  WriteSceneTest.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/12.
//

import XCTest
@testable import DidIDoMyBestToday

class WriteSceneTest: XCTestCase {
    var sut: WriteTodoTaskScenePresenter!
    var viewController: MockWriteSceneViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockWriteSceneViewController()
        //sut = MainScenePresenter(viewController: viewController)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
