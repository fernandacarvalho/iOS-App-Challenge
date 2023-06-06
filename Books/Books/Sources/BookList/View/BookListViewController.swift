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
    case highlightsHeaderView = "HighlightsHeaderView"
    case listHeaderView = "ListHeaderView"
    case loadingCell = "LoadingTableViewCell"
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

final class BookListViewController: BaseViewController {

    private var presenter: BookListPresenter!
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewWillDisplayIndex(index: 0)
    }
    
    init(presenter: BookListPresenter? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter ?? BookListPresenter(delegate: self)
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
        static let highlightsHeaderHeight: CGFloat = 100
        static let listHeaderHeight: CGFloat = 50
        static let listFooterHeight: CGFloat = 70
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
        tableView.register(ListItemsHeaderViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.listHeaderView.rawValue)
        tableView.register(HighlightsHeaderViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.highlightsHeaderView.rawValue)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.loadingCell.rawValue)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.listItemCell.rawValue) as? ListItemTableViewCell,
                  presenter.bestSellers.count > 0 else {
                return UITableViewCell()
            }
            cell.configureCell(book: presenter.bestSellers[indexPath.row])
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
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if BookListTableViewSection(rawValue: section) == .highlights {
            return tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.highlightsHeaderView.rawValue) as? HighlightsHeaderViewCell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.listHeaderView.rawValue) as? ListItemsHeaderViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return BookListTableViewSection(rawValue: section) == .highlights ? Constants.highlightsHeaderHeight : Constants.listHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if BookListTableViewSection(rawValue: section) == .items,
           presenter.isLoading,
           let footer = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.loadingCell.rawValue) as? LoadingTableViewCell {
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return BookListTableViewSection(rawValue: section) == .items && presenter.isLoading ? Constants.listFooterHeight : 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        print("willDisplayFooterView")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("didEndDisplayingFooterView")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            presenter.viewWillDisplayIndex(index: indexPath.row)
        }
    }
}

extension BookListViewController: BookListPresenterDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showErrorAlert(error: NetworkError) {
        self.showSimpleAlert(withTitle: error.message, andMessage: error.localizedDescription)
    }
}
