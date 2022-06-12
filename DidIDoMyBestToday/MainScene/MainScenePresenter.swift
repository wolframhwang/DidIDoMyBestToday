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
    
    func viewWillAppear() {
        todaysTask()
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
        
    }
    
    func didTappedAddTodoTask() {
        viewController?.showWriteTodoTask()
    }
}

extension MainScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
                    .dequeueReusableCell(withIdentifier: "TodoListTableCell", for: indexPath)
                    as! TodoListTableCell

        cell.setText(text: tasks[indexPath.row].title)
        cell.setImage(point: changeSatisfyToScore(score: tasks[indexPath.row].satisfy))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension MainScenePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
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
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
        
    }
    
    /// 불필요한 테스팅용 함수임
    func getTasks() -> [TaskData] {
        return tasks
    }
    
    func changeSatisfyToScore(score: Int) -> ScoreEnum {
        switch score {
        case 1:
            return .one
        case 2:
            return .two
        case 3:
            return .three
        case 4:
            return .four
        case 5:
            return .five
        default:
            return .zero
        }
    }
}
