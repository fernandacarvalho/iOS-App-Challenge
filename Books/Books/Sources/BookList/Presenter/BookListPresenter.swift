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

protocol BookListPresenterProtocol {
    var delegate: BookListPresenterDelegate? { get }
    var service: BookListServiceProtocol { get }
    var bestSellers: [Book] { get }
    var topFiveBooks: [Book] { get }
    var offset: Int { get }
    var total: Int { get }
    var itemsForPage: Int { get }
    func shouldGetMoreItems(index: Int) -> Bool
    func getBestSellersHistory()
    func shouldShowEmptyListPlaceholder() -> Bool
    func numberOfRowsForHighlights() -> Int
    func numberOfRowsForList() -> Int
}

final class BookListPresenter: BookListPresenterProtocol {
    
    internal weak var delegate: BookListPresenterDelegate?
    internal var service: BookListServiceProtocol
    
    private(set) var bestSellers = [Book]()
    private(set) var topFiveBooks = [Book]()
    
    private(set) var offset = 0
    private(set) var total = 0
    internal let itemsForPage = 20
    
    private(set) var isLoadingList = false
    private(set) var isLoadingHighlights = false
    
    private(set) var emptyListTitle = "The list is empty"
    
    init(delegate: BookListPresenterDelegate, service: BookListServiceProtocol = BookListService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func viewWillDisplayIndex(index: Int) {
        if shouldGetMoreItems(index: index) {
            getBestSellersHistory()
        }
    }
    
    func shouldGetMoreItems(index: Int) -> Bool {
        return (offset < total || total == 0) && ((bestSellers.count - index <= 10) && (index >= bestSellers.count/2)) && !isLoadingList
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

internal extension BookListPresenter {
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
            bestSellers.append(contentsOf: filterEmptyEntries(books: books))
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
        self.topFiveBooks = filterEmptyEntries(books: books)
        self.delegate?.reloadTableView()
    }
    
    func handleHighlightsError(error: NetworkError) {
        //TODO
    }
    
    func filterEmptyEntries(books: [Book]) -> [Book] {
        return books.filter {$0.title != nil && $0.author != nil}
    }
}
