//
//  ComposeSceneProtocol.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/13.
//

import Foundation
import UIKit

protocol ComposeSceneProtocol: AnyObject {
    func setLayout()
    func setAttribute()
    func closeWindow()
    func getWidth() -> CGFloat
    func viewAlert()
}
