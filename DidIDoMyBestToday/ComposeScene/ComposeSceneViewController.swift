//
//  ComposeSceneViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/13.
//

import Foundation
import UIKit
import SnapKit

class ComposeSceneViewController: UIViewController {
    private lazy var presenter: ComposeScenePresenter? = nil
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WriteTitleCell.self, forCellReuseIdentifier: "WriteTitleCell")
        tableView.register(WriteContentCell.self, forCellReuseIdentifier: "WriteContentCell")
        tableView.register(PointSelectCell.self, forCellReuseIdentifier: "PointSelectCell")
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.backgroundColor = .white
        
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
        button.image = UIImage(systemName: "x.circle.fill")
        button.tintColor = .lightGray
        
        return button
    }()
    
    init(presenter: ComposeScenePresenter?) {
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
    
    @objc func didTappedSubmitButton() {
        presenter?.didTappedSubmitButton()
    }
    
    @objc func didTappedCloseButton() {
        presenter?.didTappedCloseButton()
    }
}

extension ComposeSceneViewController: ComposeSceneProtocol {
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
        navigationItem.rightBarButtonItem = submitButton
        
    }
    
    func closeWindow() {
        dismiss(animated: true)
    }
    
    func getWidth() -> CGFloat {
        return view.frame.width
    }
    
    func viewAlert() {
        let alertView = UIAlertController(title: "실패!",
                                          message: "변경 사항이 없습니다.",
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alertView.addAction(action)
        present(alertView, animated: true)
    }
}
