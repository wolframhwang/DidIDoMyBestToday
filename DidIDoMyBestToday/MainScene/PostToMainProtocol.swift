//
//  WriteToMainProtocol.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation

protocol PostToMainProtocol: AnyObject {
    func registerTaskInform(data: TaskData)
    func modifyTaskInfrom(data: TaskData, index: Int)
}
