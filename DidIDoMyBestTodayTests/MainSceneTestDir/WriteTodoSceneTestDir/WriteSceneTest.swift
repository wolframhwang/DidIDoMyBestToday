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
    var sutMain: MainScenePresenter!
    var viewController: MockWriteSceneViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockWriteSceneViewController()
        sut = WriteTodoTaskScenePresenter(viewController, sutMain)
    }
    
    func test_initialize() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetAttribute)
        XCTAssertTrue(viewController.isCalledSetLayout)
    }
    
    func test_() {
        sut.didTappedCloseButton()
        XCTAssertTrue(viewController.isCalledCloseWindow)
        viewController.isCalledCloseWindow = false
        XCTAssertFalse(viewController.isCalledCloseWindow)
        sut.didTappedSubmitButton()
        XCTAssertTrue(viewController.isCalledCloseWindow)
    }
    
    func test_reload() {
        sut.viewWillAppear()
        XCTAssertTrue(viewController.isCalledReLoadDAta)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
