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
    private var tasks: [TaskData] = []
    private let realm = RealmDataManager()
    private let today = Date()
    
    init(viewController: MainSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
            self?.viewController?.setAttribute()
        }
    }
    
    func didTappedAddTodoTask() {
        viewController?.showWriteTodoTask()
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
        if month < 10 {
            return "\(year)-0\(month)-\(day)"
        }
        return "\(year)-\(month)-\(day)"
    }
    
    func todaysTask() {
        self.tasks = realm.getRealmDataInfo(condition: getToday())
    }
    
    /// 불필요한 테스팅용 함수임
    func getTasks() -> [TaskData] {
        return tasks
    }
}
