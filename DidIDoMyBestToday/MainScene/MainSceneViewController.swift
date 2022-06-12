//
//  ViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/10.
//

import UIKit

class MainSceneViewController: UIViewController {
    @IBOutlet weak var todoListView: UITableView!
    
    private lazy var presenter = MainScenePresenter(viewController: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }


}

extension MainSceneViewController: MainSceneProtocol {
    func setLayout() {
        
    }
    
    func setAttribute() {
        todoListView.delegate = presenter
        todoListView.dataSource = presenter
    }
}
