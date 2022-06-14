//
//  TodoListTableCell.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import UIKit
import SnapKit

class TodoListTableCell: UITableViewCell {
    private lazy var titleText = UILabel()
    private lazy var imgView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [imgView, titleText].forEach {
            self.addSubview($0)
        }
        
        imgView.snp.makeConstraints {
            $0.leading.equalTo(5)
            $0.size.width.height.equalTo(self.snp.height)
        }
        
        titleText.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(5)
            $0.top.bottom.trailing.equalTo(0).inset(5)
        }
    }
    
    func setImage(point: ScoreEnum) {
        imgView.image = UIImage(systemName: "checkmark")
        imgView.tintColor = point.color
    }
    
    func setText(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.titleText.text = text
            
        }
    }
    
}
