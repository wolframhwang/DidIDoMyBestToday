//
//  WriteTodoListTaskScenePresenter.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit

class WriteTodoTaskScenePresenter : NSObject {
    private weak var viewController: WriteTodoTaskSceneProtocol?
    private weak var mainPresenter: PostToMainProtocol?
    private let writeTitlePresenter = WriteTitlePresenter(writeTitelCell: nil)
    private let writeContentPresenter = WriteContentPresenter(writeContent: nil)
    private let today = Date()
    
    init(_ viewController: WriteTodoTaskSceneProtocol?, _ mainPresenter: PostToMainProtocol?) {
        self.viewController = viewController
        self.mainPresenter = mainPresenter
    }
    
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.setLayout()
            self?.viewController?.setAttribute()
        }
    }
    
    func viewWillAppear() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.reloadData()
        }
    }
    
    func setViewController(viewController: WriteTodoTaskSceneViewController?) {
        self.viewController = viewController
    }
    
    func setMainPresenter(mainPresenter: PostToMainProtocol?) {
        self.mainPresenter = mainPresenter
    }
    
    func didTappedSubmitButton() {        
        let taskData = TaskData(title: writeTitlePresenter.getText(),
                            contents: writeContentPresenter.getText(),
                            satisfy: 0,
                            date: getToday())
        mainPresenter?.dataInform(data: taskData)
        viewController?.closeWindow()
    }
    
    func didTappedCloseButton() {
        viewController?.closeWindow()
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
}

extension WriteTodoTaskScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WriteTitleCell", for: indexPath) as! WriteTitleCell
            writeTitlePresenter.setView(writeTitelCell: cell)
            cell.setPresenter(presenter: writeTitlePresenter)
            cell.setLayout()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WriteContentCell", for: indexPath) as! WriteContentCell
            writeContentPresenter.setView(writeContent: cell)
            cell.setPresenter(presenter: writeContentPresenter)
            cell.setLayout()
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
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
            return 20
        }
    }
}

extension WriteTodoTaskScenePresenter: UITableViewDelegate {
    
}
