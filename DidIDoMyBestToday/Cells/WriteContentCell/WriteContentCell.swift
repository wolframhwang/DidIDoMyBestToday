//
//  WriteContentCell.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import UIKit

class WriteContentCell: UITableViewCell, WriteProtocol {
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        
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
    }
        
}
