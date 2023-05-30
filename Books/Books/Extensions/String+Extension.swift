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
    
    func maxLength(length: Int) -> String {
           var str = self
           let nsString = str as NSString
           if nsString.length >= length {
               str = nsString.substring(with:
                   NSRange(
                    location: 0,
                    length: nsString.length > length ? length : nsString.length)
               )
               str = str + "..."
           }
           return  str
       }
}
