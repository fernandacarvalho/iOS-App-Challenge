//
//  BestSellers.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import Foundation

struct BestSellers: Codable {
    let numResults: Int?
    let results: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results = "results"
    }
}

struct TopFive: Codable {
    let results: TopFiveResult?
}

struct TopFiveResult: Codable {
    let lists: [TopFiveList]?
}

struct TopFiveList: Codable {
    let listName: String?
    let books: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case books = "books"
    }
}
