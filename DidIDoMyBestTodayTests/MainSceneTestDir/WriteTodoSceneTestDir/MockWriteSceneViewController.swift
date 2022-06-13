//
//  MockWriteSceneViewController.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/12.
//

import XCTest
@testable import DidIDoMyBestToday

class MockWriteSceneViewController: WriteTodoTaskSceneProtocol {
    var isCalledSetLayout: Bool = false
    var isCalledSetAttribute: Bool = false
    var isCalledReLoadDAta: Bool = false
    var isCalledCloseWindow: Bool = false
    
    func setLayout() {
        isCalledSetLayout = true
    }
    
    func setAttribute() {
        isCalledSetAttribute = true
    }
    
    func reloadData() {
        isCalledReLoadDAta = true
    }
    
    func closeWindow() {
        isCalledCloseWindow = true
    }
    

    
}
