//
//  BookListPresenter.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 23/05/23.
//

import Foundation

protocol BookListPresenterDelegate: AnyObject {
    func reloadTableView()
    func showPlaceholder(title: String, message: String, btnTitle: String)
}

final class BookListPresenter: NSObject {
    
    private weak var delegate: BookListPresenterDelegate?
    private var service: BookListService
    private(set) var bestSellers = [Book]() {
        didSet {
            bestSellers = bestSellers.filter {$0.title != nil}
        }
    }
    private var offset = 0
    private var total = 0
    private(set) var isLoadingList = false
    private(set) var isLoadingHighlights = false
    private let itemsForPage = 20
    private(set) var emptyListTitle = "The list is empty"
    private(set) var topFiveBooks = [Book]() {
        didSet {
            topFiveBooks = topFiveBooks.filter {$0.title != nil}
        }
    }
    
    init(delegate: BookListPresenterDelegate, service: BookListService = BookListService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func viewWillDisplayIndex(index: Int) {
        if offset < total || total == 0, offset - index <= 10, !isLoadingList {
            getBestSellersHistory()
        }
    }
    
    func shouldShowEmptyListPlaceholder() -> Bool {
        return bestSellers.count == 0 && !isLoadingList
    }
    
    func shouldShowLoadingListCell() -> Bool {
        return isLoadingList
    }
    
    func shouldShowLoadingHighlightsCell() -> Bool {
        return isLoadingHighlights
    }
    
    func numberOfRowsForHighlights() -> Int {
        return self.topFiveBooks.count > 0 ? 1 : 0
    }
    
    func numberOfRowsForList() -> Int {
        return shouldShowEmptyListPlaceholder() ? 1 : bestSellers.count
    }
    
    func getTopFive() {
        let now = Date()
        isLoadingHighlights = true
        service.getTopFiveList(date: now.getDateString(format: DateFormat.yyyyMMdd.rawValue)) { [weak self] (result: Result<TopFive, NetworkError>) in
            self?.isLoadingHighlights = false
            switch result {
            case .success(let topFive):
                self?.handleHighlightsSuccess(topFive: topFive)
                
            case .failure(let error):
                self?.handleHighlightsError(error: error)
            }
        }
    }
}

fileprivate extension BookListPresenter {
    func getBestSellersHistory() {
        isLoadingList = true
        service.getBookList(offset: offset) { [weak self] (result: Result<BestSellers, NetworkError>) in
            self?.isLoadingList = false
            switch result {
            case .success(let bestSellers):
                self?.handleGetListSuccess(list: bestSellers)
                
            case .failure(let error):
                self?.handleGetListError(error: error)
            }
        }
    }
    
    func handleGetListSuccess(list: BestSellers) {
        if let books = list.results, books.count > 0 {
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
        self.delegate?.showPlaceholder(
            title: "Ops!",
            message: error.message,
            btnTitle: "Try again"
        )
    }
    
    func handleHighlightsSuccess(topFive: TopFive) {
        guard let books = topFive.results?.lists?.first?.books else {
            handleHighlightsError(error: .unknownError(message: "Unable to retrive Top 5 Books"))
            return
        }
        self.topFiveBooks = books
        self.delegate?.reloadTableView()
    }
    
    func handleHighlightsError(error: NetworkError) {
        //TODO
    }
}
