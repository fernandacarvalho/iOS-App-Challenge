//
//  UrlFactoryUtil.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import Foundation

final class UrlFactoryUtil {
    static let baseUrl = "https://api.nytimes.com/svc"
    private static let apiKey = "SaIcSflYTwrmhxEqOsX7MvuMbFVvuLz6"
    
    class BookList {
        class func getBestSellersUrl(offset: Int) -> String {
            let path = "/books/v3/lists/best-sellers/history.json"
            let query = offset > 0 ? "&offset=\(offset)" : ""
            return UrlFactoryUtil.baseUrl + path + "?api-key=\(UrlFactoryUtil.apiKey)" + query
        }
    }
}
