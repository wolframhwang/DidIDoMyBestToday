//
//  WriteContentCell.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import UIKit

class WriteContentCell: UITableViewCell {
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .black
        textView.backgroundColor = .white
        
        return textView
    }()
    private lazy var presenter: WriteContentPresenter? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLayout()
    }
    
    func setPresenter(presenter: WriteContentPresenter?) {
        self.presenter = presenter
        textView.delegate = self.presenter
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func setLayout() {
        self.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        self.backgroundColor = .white
    }
        
}

extension WriteContentCell: WriteProtocol {
    func setText(text: String) {
        textView.text = text
    }
    
    func getInnerText() -> String {
        guard let text = textView.text else { return "" }
        return text
    }
    
    func setEditDisable() {
        textView.isUserInteractionEnabled = false
    }
}
