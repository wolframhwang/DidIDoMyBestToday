//
//  WriteToDoTaskSceneViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/12.
//

import Foundation
import UIKit
import SnapKit

class WriteTodoTaskSceneViewController: UIViewController {
    private lazy var presenter: WriteTodoTaskScenePresenter? = nil
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WriteTitleCell.self, forCellReuseIdentifier: "WriteTitleCell")
        tableView.register(WriteContentCell.self, forCellReuseIdentifier: "WriteContentCell")
        //tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    private lazy var submitButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.action = #selector(didTappedSubmitButton)
        button.image = .add
        button.tintColor = .lightGray
        
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.action = #selector(didTappedCloseButton)
        button.image = .remove
        button.tintColor = .lightGray
        
        return button
    }()
    
    
    init(presenter: WriteTodoTaskScenePresenter?) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("WriteTodoTask Scene Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @objc func didTappedSubmitButton() {
        presenter?.didTappedSubmitButton()
    }
    
    @objc func didTappedCloseButton() {
        presenter?.didTappedCloseButton()
    }
}

extension WriteTodoTaskSceneViewController: WriteTodoTaskSceneProtocol {
    func setLayout() {
        [tableView].forEach {
            view.addSubview($0)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        title = "할 일 추가하기"
        navigationItem.rightBarButtonItem = submitButton
        navigationItem.leftBarButtonItem = closeButton
        tableView.dataSource = presenter
        tableView.delegate = presenter
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func closeWindow() {
        self.dismiss(animated: true)
    }
}
