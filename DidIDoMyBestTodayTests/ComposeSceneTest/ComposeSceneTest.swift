//
//  ComposeSceneTest.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/13.
//

import XCTest
@testable import DidIDoMyBestToday

class ComposeSceneTest: XCTestCase {
    var sut: ComposeScenePresenter!
    var viewController: MockComposeSceneViewController!
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetLayout)
        XCTAssertTrue(viewController.isCalledSetAttribute)
    }
    
    func test_didTappedPoint() {
        sut.didTappedPoint(point: 1)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 1)
        sut.didTappedPoint(point: 2)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 2)
        sut.didTappedPoint(point: 1)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 1)
        sut.didTappedPoint(point: 3)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 3)
        sut.didTappedPoint(point: 1)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 1)
        sut.didTappedPoint(point: 4)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 4)
        sut.didTappedPoint(point: 1)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 1)
        sut.didTappedPoint(point: 5)
        XCTAssertEqual(viewController.isCalledDidTappedPoint, 5)
    }
    
    func test_didTappedCloseButton() {
        sut.didTappedCloseButton()
        XCTAssertTrue(viewController.isCalledDidTappedClosebutton)
    }
    
    func test_didTappedSubmitButton() {
        sut.didTappedSubmitButton()
        XCTAssertTrue(viewController.isCalledDidTappedSubmitButton)
    }
}
