//
//  PointSelectCell.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/14.
//

import UIKit
import SnapKit

class PointSelectCell: UITableViewCell {
    private lazy var presenter: PointSelectPresenter? = nil
    private lazy var pointInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 점수는?"
        label.textAlignment = .center
        
        return label
    }()
    private lazy var pointOne: UIImageView = {
        let imgView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTappedPointImage(recognizer:)))
        imgView.tag = 1
        imgView.image = UIImage(systemName: "1.circle")
        imgView.tintColor = .darkGray
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    private lazy var pointTwo: UIImageView = {
        let imgView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTappedPointImage(recognizer:)))
        imgView.tag = 2
        imgView.image = UIImage(systemName: "2.circle")
        imgView.tintColor = .darkGray
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    
    private lazy var pointThree: UIImageView = {
        let imgView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTappedPointImage(recognizer:)))
        imgView.tag = 3
        imgView.image = UIImage(systemName: "3.circle")
        imgView.tintColor = .darkGray
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    
    private lazy var pointFour: UIImageView = {
        let imgView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTappedPointImage(recognizer:)))
        imgView.tag = 4
        imgView.image = UIImage(systemName: "4.circle")
        imgView.tintColor = .darkGray
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    
    private lazy var pointFive: UIImageView = {
        let imgView = UIImageView()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTappedPointImage(recognizer:)))
        imgView.tag = 5
        imgView.image = UIImage(systemName: "5.circle")
        imgView.tintColor = .darkGray
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        return imgView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func didTappedPointImage(recognizer: Any) {
        presenter?.didTappedPointImage(recognizer: recognizer as? UITapGestureRecognizer)
    }

    func setPresenter(presenter: PointSelectPresenter?) {
        self.presenter = presenter
    }
    
    func setLayout() {
        // - 1 - 2 - 3 - 4 - 5 -
        // height = width + 20
        let rectWidth = (self.frame.width - 40) / 5
        
        let heightSpacing: CGFloat = 10
        let widthSpacing: CGFloat  = 5
        [pointInfoLabel, pointOne, pointTwo, pointThree, pointFour, pointFive].forEach {
            self.addSubview($0)
        }
        pointInfoLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(15)
            $0.height.equalTo(20)
        }
        
        pointOne.snp.makeConstraints {
            $0.top.equalTo(pointInfoLabel.snp.bottom).offset(heightSpacing)
            $0.leading.equalToSuperview().offset(widthSpacing)
            $0.size.height.width.equalTo(rectWidth)
        }
        
        pointTwo.snp.makeConstraints {
            $0.top.equalTo(pointInfoLabel.snp.bottom).offset(heightSpacing)
            $0.leading.equalTo(pointOne.snp.trailing).offset(widthSpacing)
            $0.size.height.width.equalTo(rectWidth)
        }
        
        pointThree.snp.makeConstraints {
            $0.leading.equalTo(pointTwo.snp.trailing).offset(widthSpacing)
            $0.top.equalTo(pointInfoLabel.snp.bottom).offset(heightSpacing)
            $0.size.height.width.equalTo(rectWidth)
        }
        
        pointFour.snp.makeConstraints {
            $0.leading.equalTo(pointThree.snp.trailing).offset(widthSpacing)
            $0.top.equalTo(pointInfoLabel.snp.bottom).offset(heightSpacing)
            $0.size.height.width.equalTo(rectWidth)
        }
        
        pointFive.snp.makeConstraints {
            $0.leading.equalTo(pointFour.snp.trailing).offset(widthSpacing)
            $0.top.equalTo(pointInfoLabel.snp.bottom).offset(heightSpacing)
            $0.size.height.width.equalTo(rectWidth)
        }
    }
    
    func setAttribute() {
        presenter?.setAttribute()
    }
    
    func unSelectAll() {
        for point in 1...5 {
            let img = self.viewWithTag(point) as! UIImageView
            img.tintColor = .darkGray
        }
    }
}

extension PointSelectCell: PointSelectProtocol {
    func setPointAttribute(point: Int) {
        unSelectAll()
        let img = self.viewWithTag(point) as! UIImageView
        img.tintColor = .lightGray
    }
    
    func setUnselectAll() {
        unSelectAll()
    }
}
