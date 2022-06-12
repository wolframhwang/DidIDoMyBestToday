//
//  ViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/10.
//

import UIKit
import SnapKit

class MainSceneViewController: UIViewController {
    private lazy var todoListView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
                
        return tableView
    }()
    
    private lazy var presenter = MainScenePresenter(viewController: self)
    
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @objc func didTappedAddTodoTask() {
        presenter.didTappedAddTodoTask()
    }
}

extension MainSceneViewController: MainSceneProtocol {
    func setLayout() {
        [todoListView].forEach {
            view.addSubview($0)
        }
        
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAttribute() {
        
    }
    
    func showWriteTodoTask() {
        let vc = WriteTodoTaskSceneViewController()
        self.present(vc, animated: true)
    }
}
