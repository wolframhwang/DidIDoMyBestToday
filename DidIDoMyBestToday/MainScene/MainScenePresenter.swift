//
//  MainScenePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import FSCalendar
import UIKit

class MainScenePresenter: NSObject {
    private weak var viewController: MainSceneProtocol?
    private var tasks: [TaskData] = []
    private var selectDayTasks: [TaskData] = []
    private var selectDay: String = ""
    private let realm = RealmDataManager()
    private var today = Date()
    private let writePresenter = WriteTodoTaskScenePresenter(nil, nil)
    private let composePresenter = ComposeScenePresenter(viewController: nil, mainPresenter: nil)
    
    init(viewController: MainSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didDayChanged),
                                               name: NSNotification.Name.NSCalendarDayChanged,
                                               object: nil)
        writePresenter.setMainPresenter(mainPresenter: self)
        composePresenter.setMainPresenter(mainPresenter: self)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
            self?.viewController?.setAttribute()
            self?.viewController?.changeToTask()
        }
    }
    
    func viewWillAppear() {
        todaysTask()
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
        
    }
    
    func didTappedAddTodoTask() {
        viewController?.showWriteTodoTask(presenter: writePresenter)
    }
    
    @objc func didDayChanged() {
        DispatchQueue.main.async { [weak self] in
            self?.todaysTask()
            self?.viewController?.reloadData()
        }
    }
    
    func didTappedTaskList() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.changeToTask()
        }
    }
    
    func didTappedCalendarList() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.changeToCalendar()
        }
    }
}

extension MainScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
            return tasks.count
        case 1:
            return selectDayTasks.count
            break
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
                    .dequeueReusableCell(withIdentifier: "TodoListTableCell", for: indexPath)
                    as! TodoListTableCell
        switch tableView.tag {
        case 0:
            cell.setText(text: tasks[indexPath.row].title)
            cell.setImage(point: changeSatisfyToScore(score: tasks[indexPath.row].satisfy))
            break
        case 1:
            cell.setText(text: selectDayTasks[indexPath.row].title)
            cell.setImage(point: changeSatisfyToScore(score: selectDayTasks[indexPath.row].satisfy))
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension MainScenePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        switch tableView.tag {
        case 0:
            composePresenter.setTask(task: tasks[index], index: index)
            break
        case 1:
            composePresenter.setTask(task: selectDayTasks[index], index: index)
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showComposeScene(presenter: self?.composePresenter)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let tag = tableView.tag
        if tag == 1 { return .none }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm.removeRealmDataInfo(data: tasks[indexPath.row].transRealmData())
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if selectDay == getToday() {
                selectDayTasks = tasks            
                viewController?.reloadSelectDayData()
            }
        }
    }    
}

extension MainScenePresenter: PostToMainProtocol {
    func registerTaskInform(data: TaskData) {
        realm.saveRealmData(data: data.transRealmData())
        tasks.append(data)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
    }
    
    func modifyTaskInfrom(data: TaskData, index: Int) {
        realm.updateRealmDataInfo(data: data.transRealmData())
        tasks[index] = data
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
    }
}

extension MainScenePresenter: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    // What Todo?
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dayInfo = getDateInfo(dayInfo: date)
        selectDayTasks = realm.getRealmDataInfo(condition: dayInfo)
        selectDay = dayInfo
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadSelectDayData()
        }
    }
}

extension MainScenePresenter {
    func getDateInfo(dayInfo: Date) -> String {
        let year = Calendar.current.component(.year, from: dayInfo)
        let month = Calendar.current.component(.month, from: dayInfo)
        let day = Calendar.current.component(.day, from: dayInfo)
        if month < 10 {
            return "\(year)-0\(month)-\(day)"
        }
        return "\(year)-\(month)-\(day)"
    }
    
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
        today = Date()
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
