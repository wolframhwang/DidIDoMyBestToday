//
//  ViewController.swift
//  DidIDoMyBestToday
//
//  Created by 황지웅 on 2022/06/10.
//

import UIKit
import SnapKit
import FSCalendar

class MainSceneViewController: UIViewController {
    private lazy var monthCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = .white
        calendar.dataSource = presenter
        calendar.delegate = presenter
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.scrollDirection = .vertical
        calendar.placeholderType = .none
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        //calendar.layer.opacity = 0
        
        return calendar
    }()
    
    private lazy var todoListView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoListTableCell.self, forCellReuseIdentifier: "TodoListTableCell")
        tableView.backgroundColor = .white
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.isHidden = true
        
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
        button.menu = menu
        return button
    }()
    
    lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "다운로드", image: nil, handler: { _ in }),
            UIAction(title: "공유", image: UIImage(systemName: "square.and.arrow.up"), handler: { _ in }),
        ]
    }()
    lazy var menu: UIMenu = {
        return UIMenu(title: "", options: [], children: menuItems)
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
        
        [todoListView, monthCalendar].forEach {
            view.addSubview($0)
        }
        todoListView.rowHeight = UITableView.automaticDimension
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        monthCalendar.snp.makeConstraints {
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
