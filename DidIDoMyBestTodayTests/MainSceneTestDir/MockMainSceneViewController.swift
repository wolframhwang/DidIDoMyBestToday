//
//  MockMainSceneViewController.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import XCTest

@testable import DidIDoMyBestToday

class MockMainSceneViewController: MainSceneProtocol {
    var isCalledSetLayout: Bool = false
    var isCalledSetAttribute: Bool = false
    func setLayout() {
        isCalledSetLayout = true
    }
    
    func setAttribute() {
        isCalledSetAttribute = true
    }    
    
}
