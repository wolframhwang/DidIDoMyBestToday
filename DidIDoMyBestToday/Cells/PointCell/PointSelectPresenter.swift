//
//  PointSelectPresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/14.
//

import Foundation
import UIKit

class PointSelectPresenter: NSObject {
    private weak var viewController: PointSelectProtocol?
    private var point = 0
    init(viewController: PointSelectProtocol?) {
        self.viewController = viewController
    }
    
    func getPoint() -> Int {
        return point
    }
    
    func setView(viewController: PointSelectProtocol?, point: Int) {
        self.viewController = viewController
        self.point = point
    }
    
    func setAttribute() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setPointAttribute(point: (self?.point) ?? 0)
        }
    }
    
    func didTappedPointImage(recognizer: UITapGestureRecognizer?) {
        let imgView = recognizer?.view as? UIImageView
        guard let point = imgView?.tag else { return }
        
        if self.point == point {
            self.point = 0
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.setUnselectAll()
            }
        } else {
            self.point = point
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.setPointAttribute(point: point)
            }
        }
    }
}
