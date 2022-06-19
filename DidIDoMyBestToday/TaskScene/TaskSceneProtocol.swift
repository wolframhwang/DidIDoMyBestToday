//
//  TaskSceneProtocol.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/19.
//

import Foundation
import UIKit

protocol TaskSceneProtocl: AnyObject {
    func setLayout()
    func setAttribute()
    func closeWindow()
    func getWidth() -> CGFloat
}
