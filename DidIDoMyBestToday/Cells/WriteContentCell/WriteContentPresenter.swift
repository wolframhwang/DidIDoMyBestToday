//
//  WriteContentPresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit

class WriteContentPresenter: NSObject {
    private weak var writeContent: WriteProtocol?
    private var text = ""
    
    init(writeContent: WriteProtocol?) {
        self.writeContent = writeContent
    }
    
    func setView(writeContent: WriteProtocol?) {
        self.writeContent = writeContent
    }
    
    func getText() -> String {
        return writeContent?.getInnerText() ?? ""
    }
    
    func setContent(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.writeContent?.setText(text: text)
        }
    }
    
}

extension WriteContentPresenter: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        self.text = text
    }
}
