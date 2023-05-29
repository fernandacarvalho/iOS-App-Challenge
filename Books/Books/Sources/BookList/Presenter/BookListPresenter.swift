//
//  BookListPresenter.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 23/05/23.
//

import Foundation

final class BookListPresenter {
    
    func numberOfRowsForSection(section: BookListTableViewSection) -> Int {
        if section == .highlights {
            return 1
        }
        return 10
    }
}
