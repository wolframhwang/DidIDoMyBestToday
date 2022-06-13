//
//  WriteTitleCell.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import UIKit
import SnapKit

class WriteTitleCell: UITableViewCell, WriteProtocol {
    private lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        return tf
    }()
    private lazy var presenter: WriteTitlePresenter? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPresenter(presenter: WriteTitlePresenter?) {
        self.presenter = presenter
    }
    
    @objc func didChangeTextField() {
        guard let text = titleTextField.text else {
            return
        }
        presenter?.didChangeTextField(text: text)
    }
    
    func setLayout() {
        self.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview()
        }
        
        titleTextField.placeholder = "제목"
    }
    
    func getText() -> String {
        guard let text = titleTextField.text else { return "" }
        return text
    }
}
