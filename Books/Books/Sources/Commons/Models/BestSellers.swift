//
//  BestSellers.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import Foundation

struct BestSellers: Codable {
    var numResults: Int?
    var results: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results = "results"
    }
}

//struct BestSellersResult: Codable {
//    var bestSellersDate: String?
//    var lists: [BestSellersList]?
//
//    enum CodingKeys: String, CodingKey {
//        case bestSellersDate = "bestsellers_date"
//        case lists = "lists"
//    }
//}
//
//struct BestSellersList: Codable {
//    var listId: Int?
//    var listName: String?
//    var books: [Book]?
//
//    enum CodingKeys: String, CodingKey {
//        case listId = "list_id"
//        case listName = "list_name"
//        case books = "books"
//    }
//}
