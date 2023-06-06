//
//  BookListService.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 31/05/23.
//

import Foundation

final class BookListService: NSObject {
    
    func getBookList(offset:Int, completion: @escaping (Result<BestSellers, NetworkError>) -> Void) {
        let networkService = MainService()
        guard let url = URL(string: UrlFactoryUtil.BookList.getBestSellersUrl(offset: offset)) else {
            completion(.failure(.unknownError()))
            return
        }
        
        networkService.get(url: url) { (result: Result<BestSellers, NetworkError>) in
            switch result {
            case .success(let list):
                completion(.success(list))
                
            case .failure(let error):
                print(error.message)
                completion(.failure(error))
            }
        }

    }
}
