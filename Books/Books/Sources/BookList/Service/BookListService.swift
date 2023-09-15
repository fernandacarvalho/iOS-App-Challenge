//
//  BookListService.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 31/05/23.
//

import Foundation

protocol BookListServiceProtocol {
    func getBookList(offset:Int, completion: @escaping (Result<BestSellers, NetworkError>) -> Void)
    func getTopFiveList(date: String, completion: @escaping (Result<TopFive, NetworkError>) -> Void)
}

final class BookListService: BookListServiceProtocol {
    
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
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }

    }
    
    func getTopFiveList(date: String, completion: @escaping (Result<TopFive, NetworkError>) -> Void) {
        let networkService = MainService()
        guard let url = URL(string: UrlFactoryUtil.BookList.getTopFiveUrl(date: date)) else {
            completion(.failure(.unknownError()))
            return
        }
        
        networkService.get(url: url) { (result: Result<TopFive, NetworkError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
