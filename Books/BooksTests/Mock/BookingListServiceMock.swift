//
//  BookingListServiceMock.swift
//  BooksTests
//
//  Created by Fernanda FC. Carvalho on 13/09/23.
//

import Foundation
@testable import Books


class BookingListServiceMock: BookListServiceProtocol {
    
    func getBookList(offset:Int, completion: @escaping (Result<BestSellers, NetworkError>) -> Void) {
        let list  = getData()
        completion(.success(list))
    }
    
    func getTopFiveList(date: String, completion: @escaping (Result<TopFive, NetworkError>) -> Void) {
        
    }
}

extension BookingListServiceMock {
     
    func getData() -> BestSellers {
        //number of correct values (with both name and description) = 6
        let books = [
            Book(title: "FOURTH WING", author: "Rebecca Yarros", description: nil, imageUrl: nil, price: "13.00", rank: 1, publisher: "Red Tower"),
            Book(title: "TOM LAKE", author: "Ann Patchett", description: nil, imageUrl: nil, price: "0.00", rank: 2, publisher: "Harper"),
            Book(title: "LESSONS IN CHEMISTRY", author: "Bonnie Garmus", description: "A scientist and single mother living in California in the 1960s becomes a star on a TV cooking show.", imageUrl: nil, price: "22.00", rank: nil, publisher: nil),
            Book(title: "FOURTH WING", author: "Rebecca Yarros", description: nil, imageUrl: nil, price: "13.00", rank: 1, publisher: "Red Tower"),
            Book(title: "TOM LAKE", author: "Ann Patchett", description: nil, imageUrl: nil, price: "0.00", rank: 2, publisher: "Harper"),
            Book(title: "LESSONS IN CHEMISTRY", author: "Bonnie Garmus", description: "A scientist and single mother living in California in the 1960s becomes a star on a TV cooking show.", imageUrl: nil, price: "22.00", rank: nil, publisher: nil),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
              
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: nil, author: "Peter Attia with Bill", description: nil, imageUrl: nil, price: nil, rank: 10, publisher: "Red Tower"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: nil, author: "Peter Attia with Bill", description: nil, imageUrl: nil, price: nil, rank: 10, publisher: "Red Tower"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: nil, author: "Peter Attia with Bill", description: nil, imageUrl: nil, price: nil, rank: 10, publisher: "Red Tower"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
            Book(title: "THE BREAKAWAY", author: nil, description: nil, imageUrl: nil, price: nil, rank: 33, publisher: "Atria"),
        ]
        let list = BestSellers(
            numResults: 21,
            results: books
        )
        return list
    }
}
