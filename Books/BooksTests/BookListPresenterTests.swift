//
//  BookListPresenterTests.swift
//  BooksTests
//
//  Created by Fernanda FC. Carvalho on 13/09/23.
//

import XCTest
@testable import Books

final class BookListPresenterTests: XCTestCase {
    
    private var service: BookListServiceProtocol!
    private var presenter: BookListPresenterProtocol!
    private var presenterDelegate = BookListPresenterDelegateSpy()
    
    private var numberOfValidEntriesOnMock = 6
    
    override func setUpWithError() throws {
        self.service = BookingListServiceMock()
        self.presenter = BookListPresenter(delegate: self.presenterDelegate, service: service)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFilterEmptyEntries() {
        self.presenter.getBestSellersHistory()
        XCTAssert(self.presenter.bestSellers.count == self.numberOfValidEntriesOnMock)
    }
    
    func testUpdatePaginationAfterGetList() {
        self.presenter.getBestSellersHistory()
        XCTAssert(self.presenter.offset == 20)
    }
    
    func testShouldGetMoreItemsWhenHasMorePages() {
        self.presenter.getBestSellersHistory()
        let count = self.presenter.bestSellers.count //number of valid entries
        let index = count/2 //after midle of the list
        XCTAssertTrue(self.presenter.shouldGetMoreItems(index: index))
    }
    
    func testShouldGetMoreItemsWhenItsLastPage() {
        self.presenter.getBestSellersHistory() //get first page
        self.presenter.getBestSellersHistory() //get second page
        XCTAssertFalse(self.presenter.shouldGetMoreItems(index: 5))
    }
    
    func testShouldShowPlaceholderWhenItsEmpty() {
        XCTAssertTrue(self.presenter.shouldShowEmptyListPlaceholder())
    }
    
    func testShouldShowPlaceholderWhenItsNotEmpty() {
        self.presenter.getBestSellersHistory()
        XCTAssertFalse(self.presenter.shouldShowEmptyListPlaceholder())
    }
    
    func testNumberOfRowsWhenItsEmpty() {
        XCTAssert(self.presenter.numberOfRowsForList() == 1)
    }
    
    func testNumberOfRowsWhenHasData() {
        self.presenter.getBestSellersHistory()
        XCTAssert(self.presenter.bestSellers.count == self.numberOfValidEntriesOnMock)
    }
    
    func testUpdateListWhenGetNewItems() {
        self.presenter.getBestSellersHistory()
        XCTAssert(self.presenterDelegate.didCallReloadListCount == 1)
    }
}

class BookListPresenterDelegateSpy: BookListPresenterDelegate {
    
    var didCallReloadListCount = 0
    
    func reloadTableView() {
        didCallReloadListCount += 1
    }
    
    func showPlaceholder(title: String, message: String, btnTitle: String) {}
}
