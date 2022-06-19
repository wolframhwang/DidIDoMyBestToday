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
    private lazy var calendarTaskList: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoListTableCell.self, forCellReuseIdentifier: "TodoListTableCell")
        tableView.backgroundColor = .white
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.tag = 1
        tableView.layer.opacity = 0
        
        return tableView
    }()
    
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
        calendar.layer.opacity = 0
        
        return calendar
    }()
    
    private lazy var todoListView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoListTableCell.self, forCellReuseIdentifier: "TodoListTableCell")
        tableView.backgroundColor = .white
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.tag = 0
        
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
    
    private lazy var menuItems: [UIAction] = {
        return [
            taskList,
            calendarList,
        ]
    }()
    
    private lazy var taskList: UIAction = {
        let action = UIAction(title: "체크리스트", image: nil, handler: { [weak self] _ in
            self?.didTappedTaskList()
        })
        
        return action
    }()
    
    private lazy var calendarList: UIAction = {
        let action = UIAction(title: "달력", image: nil, handler: { [weak self] _ in
            self?.didTappedCalendarList()
        })
        
        return action
    }()
    
    
    private lazy var menu: UIMenu = {
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
    
    func didTappedTaskList() {
        presenter.didTappedTaskList()
    }
    
    func didTappedCalendarList() {
        presenter.didTappedCalendarList()
    }
}

extension MainSceneViewController: MainSceneProtocol {
    func setLayout() {
        let height = view.frame.height
        
        navigationItem.rightBarButtonItem = addTaskButton
        navigationItem.leftBarButtonItem = menuButton
        
        [todoListView, monthCalendar, calendarTaskList].forEach {
            view.addSubview($0)
        }
        todoListView.rowHeight = UITableView.automaticDimension
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        monthCalendar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(height / 3)
        }
        
        calendarTaskList.snp.makeConstraints {
            $0.top.equalTo(monthCalendar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
    
    func showTaskScene(presenter: TaskScenePresenter?) {
        let vc = TaskSceneViewController(presenter: presenter)
        presenter?.setViewController(viewController: vc)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.backgroundColor = .systemYellow
        self.present(nav, animated: true)
    }
    
    func changeToTask() {
        todoListView.isHidden = false
        UIView.animate(withDuration: 1.0, animations: {
            self.todoListView.layer.opacity = 1
            self.monthCalendar.layer.opacity = 0
            self.calendarTaskList.layer.opacity = 0
        }, completion: { _ in
            self.monthCalendar.isHidden = true
            self.calendarTaskList.isHidden = true
        })
    }
    
    func changeToCalendar() {
        monthCalendar.isHidden = false
        calendarTaskList.isHidden = false
        UIView.animate(withDuration: 1.0, animations: {
            self.monthCalendar.layer.opacity = 1
            self.calendarTaskList.layer.opacity = 1
            self.todoListView.layer.opacity = 0
        }, completion: { _ in
            self.todoListView.isHidden = true
        })
    }
    
    func reloadSelectDayData() {
        calendarTaskList.reloadData()
    }
}
