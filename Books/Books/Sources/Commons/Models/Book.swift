//
//  Book.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 29/05/23.
//

import Foundation

struct Book: Codable {
    var title: String?
    var author: String?
    var description: String?
    var imageUrl: String?
    var price: String?
    var rank: Int?
    var publisher: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case description = "description"
        case imageUrl = "book_image"
        case price = "price"
        case rank = "rank"
        case publisher = "publisher"
    }
}
