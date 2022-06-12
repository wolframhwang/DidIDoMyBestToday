//
//  ScoreEnum.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit

enum ScoreEnum {
    case zero
    case one
    case two
    case three
    case four
    case five
    
    var color: UIColor {
        switch self {
        case .zero:
            return .gray
        case .one:
            return .red
        case .two:
            return .orange
        case .three:
            return .yellow
        case .four:
            return .green
        case .five:
            return .blue
        }
    }
}
