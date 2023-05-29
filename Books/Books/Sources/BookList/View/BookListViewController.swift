//
//  BookListViewController.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 23/05/23.
//

import UIKit

fileprivate enum CellReuseIdentifier: String {
    case highlightsCell = "HighlightsTableViewCell"
    case listItemCell = "ListItemTableViewCell"
}

enum BookListTableViewSection: Int {
    case highlights
    case items
    
    static let count: Int = {
        var max: Int = 0
        while let _ = BookListTableViewSection(rawValue: max) { max += 1 }
        return max
    }()
}

final class BookListViewController: UIViewController {

    private var presenter: BookListPresenter!
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(presenter: BookListPresenter? = BookListPresenter()) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - VIEW SETUP

fileprivate extension BookListViewController {
    
    enum Constants {
        static let estimatedRowHeight: CGFloat = 300
        static let highlightRowHeight: CGFloat = 200
    }
    
    func setup() {
        self.view.backgroundColor = .backgroundColor
        setupTableViewCell()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupTableViewCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(HighlightsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.highlightsCell.rawValue)
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.listItemCell.rawValue)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.isUserInteractionEnabled = true
    }
    
    func setupViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

//MARK: - UITABLEVIEW DELEGATE AND DATASOURCE

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return BookListTableViewSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsForSection(section: BookListTableViewSection(rawValue: section)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch BookListTableViewSection(rawValue: indexPath.section) {
        case .highlights:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.highlightsCell.rawValue) as? HighlightsTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case .items:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.listItemCell.rawValue) as? ListItemTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if BookListTableViewSection(rawValue: indexPath.section) == .highlights {
            return Constants.highlightRowHeight
        }
        return UITableView.automaticDimension
    }
     
}
