//
//  MockComposeSceneViewController.swift
//  DidIDoMyBestTodayTests
//
//  Created by 황지웅 on 2022/06/13.
//

import Foundation
@testable import DidIDoMyBestToday

class MockComposeSceneViewController: ComposeSceneProtocol {
    var isCalledSetLayout: Bool = false
    var isCalledSetAttribute: Bool = false
    var isCalledDidTappedPoint: Int = 0
    var isCalledDidTappedSubmitButton: Bool = false
    var isCalledDidTappedClosebutton: Bool = false
    
    
}
