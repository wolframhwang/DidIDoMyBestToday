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
        tableView.register(TodoListTableCell.self, forCellReuseIdentifier: "TodoListTableCell")
        tableView.backgroundColor = .white
        tableView.delegate = presenter
        tableView.dataSource = presenter
                
        return tableView
    }()
    private lazy var addTaskButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(didTappedAddTodoTask)
        button.target = self
        button.image = UIImage(systemName: "plus")
        button.tintColor = .darkGray
        
        return button
    }()
    private lazy var menuButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "line.horizontal.3")
        button.tintColor = .darkGray
        
        return button
    }()
    
    private lazy var presenter = MainScenePresenter(viewController: self)
    
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    @objc func didTappedAddTodoTask() {
        presenter.didTappedAddTodoTask()
    }
}

extension MainSceneViewController: MainSceneProtocol {
    func setLayout() {
        navigationItem.rightBarButtonItem = addTaskButton
        navigationItem.leftBarButtonItem = menuButton
        
        [todoListView].forEach {
            view.addSubview($0)
        }
        todoListView.rowHeight = UITableView.automaticDimension
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAttribute() {
        title = "오늘 난 열심히 살았는가"
        view.backgroundColor = .white
    }
    
    func showWriteTodoTask(presenter: WriteTodoTaskScenePresenter?) {
        let vc = WriteTodoTaskSceneViewController(presenter: presenter)
        presenter?.setViewController(viewController: vc)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.backgroundColor = .systemYellow
        self.present(nav, animated: true)
    }
    
    func reloadData() {
        todoListView.reloadData()
    }
    
    func showComposeScene(presenter: ComposeScenePresenter?) {
        let vc = ComposeSceneViewController(presenter: presenter)
        presenter?.setViewController(viewController: vc)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.backgroundColor = .systemYellow
        self.present(nav, animated: true)
    }
}
