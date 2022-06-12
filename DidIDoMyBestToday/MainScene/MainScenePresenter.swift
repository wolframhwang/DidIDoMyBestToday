//
//  MainScenePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation

class MainScenePresenter: NSObject {
    private weak var viewController: MainSceneProtocol?
    
    init(viewController: MainSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
            self?.viewController?.setAttribute()
        }        
    }
}
