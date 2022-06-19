//
//  WriteTitlePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit

class WriteTitlePresenter: NSObject {
    private weak var writeTitleCell: WriteProtocol?
    private var text: String = ""
    init(writeTitelCell: WriteProtocol?) {
        self.writeTitleCell = writeTitelCell
    }
    func setView(writeTitelCell: WriteProtocol?) {
        self.writeTitleCell = writeTitelCell
    }
    func didChangeTextField(text: String) {
        self.text = text
    }
    
    func getText() -> String {
        return writeTitleCell?.getInnerText() ?? ""
    }
    
    func setText(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.writeTitleCell?.setText(text: text)
        }
    }
    
    func setEditDisable() {
        writeTitleCell?.setEditDisable()
    }
}
