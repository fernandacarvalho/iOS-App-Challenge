//
//  String+Extension.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import Foundation

public extension String {
    var withoutWhiteSpaces: String {
        return self.replacingOccurrences(of: "^\\s+|\\s+|\\s+$",
                                         with: "",
                                         options: .regularExpression)
    }
}
