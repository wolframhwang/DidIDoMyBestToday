//
//  MainSceneTest.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/12.
//

import XCTest
@testable import DidIDoMyBestToday

class MainSceneTest: XCTestCase {
    var sut: MainScenePresenter!
    var viewController: MockMainSceneViewController!
    
    override func setUp() {
        super.setUp()
        viewController = MockMainSceneViewController()
        
        sut = MainScenePresenter(viewController: viewController)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(viewController.isCalledSetLayout)
        XCTAssertTrue(viewController.isCalledSetAttribute)                
    }
    
    func test_showWriteTodoTask() {
        sut.didTappedAddTodoTask()
        
        XCTAssertTrue(viewController.isCalledShowWriteTodoTask)
    }
    
    func test_getToday() {
        XCTAssertEqual(sut.getToday(), "2022-06-12")
    }
    
    func test_toDays() {
        sut.todaysTask()
        print(sut.getTasks())
        XCTAssertEqual(sut.getTasks().count, 4)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
