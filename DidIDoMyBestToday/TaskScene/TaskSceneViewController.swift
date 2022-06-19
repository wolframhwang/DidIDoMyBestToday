//
//  TaskSceneViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/19.
//

import Foundation
import UIKit

class TaskSceneViewController: UIViewController {
    private lazy var presenter: TaskScenePresenter? = nil
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WriteTitleCell.self, forCellReuseIdentifier: "WriteTitleCell")
        tableView.register(WriteContentCell.self, forCellReuseIdentifier: "WriteContentCell")
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.action = #selector(didTappedCloseButton)
        button.image = UIImage(systemName: "x.circle.fill")
        button.tintColor = .lightGray
        
        return button
    }()
    
    init(presenter: TaskScenePresenter?) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("Compose Scene Error Occured")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @objc func didTappedCloseButton() {
        presenter?.didTappedCloseButton()
    }
}

extension TaskSceneViewController: TaskSceneProtocl {
    func setLayout() {
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        title = "To-do Task"
        navigationItem.leftBarButtonItem = closeButton        
    }
    
    func closeWindow() {
        dismiss(animated: true)
    }
    
    func getWidth() -> CGFloat {
        return view.frame.width
    }
}
