//
//  ComposeScenePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/13.
//

import Foundation
import UIKit

class ComposeScenePresenter: NSObject {
    private weak var viewController: ComposeSceneProtocol? = nil
    private weak var mainPresenter: PostToMainProtocol? = nil
    
    private var taskData: TaskData? = nil
    private var taskIndex = 0
    
    private let writeTitlePresenter = WriteTitlePresenter(writeTitelCell: nil)
    private let writeContentPresenter = WriteContentPresenter(writeContent: nil)
    private let pointSelectPresenter = PointSelectPresenter(viewController: nil)
    
    init(viewController: ComposeSceneProtocol?, mainPresenter: PostToMainProtocol?) {
        self.viewController = viewController
        self.mainPresenter = mainPresenter
    }
    
    func setTask(task: TaskData, index: Int) {
        taskData = task
        taskIndex = index
    }
        
    func setViewController(viewController: ComposeSceneProtocol?) {
        self.viewController = viewController
    }
    
    func setMainPresenter(mainPresenter: PostToMainProtocol?) {
        self.mainPresenter = mainPresenter
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
            self?.viewController?.setAttribute()
        }
    }
    
    
    
    func didTappedSubmitButton() {
        let title = writeTitlePresenter.getText()
        let contents = writeContentPresenter.getText()
        let point = pointSelectPresenter.getPoint()

        guard let taskData = taskData else {
            return
        }

        if title == taskData.title,
           contents == taskData.contents,
           point == taskData.satisfy {
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.viewAlert()
            }
        } else {
            let commitTask = TaskData(id: taskData.id,
                                      title: title,
                                      contents: contents,
                                      satisfy: point,
                                      date: taskData.date)
            
            mainPresenter?.modifyTaskInfrom(data: commitTask, index: taskIndex)
            
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.closeWindow()
            }
        }
    }
    
    func didTappedCloseButton() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.closeWindow()
        }
    }
    
    func didTappedPoint(point: Int) {
        
    }
}

extension ComposeScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let task = taskData else { return UITableViewCell() }
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WriteTitleCell", for: indexPath) as! WriteTitleCell
            writeTitlePresenter.setView(writeTitelCell: cell)
            cell.setPresenter(presenter: writeTitlePresenter)
            cell.setLayout()
            cell.setText(text: task.title)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WriteContentCell", for: indexPath) as! WriteContentCell
            writeContentPresenter.setView(writeContent: cell)
            cell.setPresenter(presenter: writeContentPresenter)
            cell.setLayout()
            cell.setText(text: task.contents)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PointSelectCell", for: indexPath) as! PointSelectCell
            pointSelectPresenter.setView(viewController: cell, point: task.satisfy)
            cell.setPresenter(presenter: pointSelectPresenter)
            cell.setLayout()
            cell.selectionStyle = .none
            return cell
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        switch row {
        case 0:
            return 40
        case 1:
            return 200
        default:
            let width = (viewController?.getWidth() ?? 0)  - 40
            let height = (width / 5) + 65
            return height
        }
    }
}

extension ComposeScenePresenter: UITableViewDelegate {
    
}
