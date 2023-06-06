//
//  BookListPresenter.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 23/05/23.
//

import Foundation

protocol BookListPresenterDelegate: AnyObject {
    func reloadTableView()
    func showErrorAlert(error: NetworkError)
}

final class BookListPresenter: NSObject {
    
    private weak var delegate: BookListPresenterDelegate?
    private var service: BookListService
    private(set) var bestSellers = [Book]()
    private var offset = 0
    private var total = 0
    private(set) var isLoading = false
    private let itemsForPage = 20
    
    init(delegate: BookListPresenterDelegate, service: BookListService = BookListService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func viewWillDisplayIndex(index: Int) {
        if offset < total || total == 0, offset - index <= 10, !isLoading {
            getBestSellersHistory()
        }
    }
    
    func numberOfRowsForSection(section: BookListTableViewSection) -> Int {
        if section == .highlights {
            return 1
        }
        return bestSellers.count
    }
}

fileprivate extension BookListPresenter {
    func getBestSellersHistory() {
        isLoading = true
        service.getBookList(offset: offset) { [weak self] (result: Result<BestSellers, NetworkError>) in
            self?.isLoading = false
            switch result {
            case .success(let bestSellers):
                self?.handleGetListSuccess(list: bestSellers)
            case .failure(let error):
                self?.handleGetListError(error: error)
            }
        }
    }
    
    func handleGetListSuccess(list: BestSellers) {
        if let books = list.results {
            bestSellers.append(contentsOf: books)
            offset += itemsForPage
        }
        if let numResults = list.numResults {
            total = numResults
        }
        delegate?.reloadTableView()
    }
    
    func handleGetListError(error: NetworkError) {
        delegate?.reloadTableView()
        delegate?.showErrorAlert(error: error)
    }
}
