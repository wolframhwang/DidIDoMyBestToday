//
//  MainScenePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit

class MainScenePresenter: NSObject {
    private weak var viewController: MainSceneProtocol?
    let today = Date()
    
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

extension MainScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension MainScenePresenter: UITableViewDelegate {
    
}

extension MainScenePresenter {
    func getToday() -> String {
        let year = Calendar.current.component(.year, from: today)
        let month = Calendar.current.component(.month, from: today)
        let day = Calendar.current.component(.day, from: today)
        return "\(year)-\(month)-\(day)"
    }
}
