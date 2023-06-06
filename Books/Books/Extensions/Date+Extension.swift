//
//  Date+Extension.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.setLocalizedDateFormatFromTemplate(dateFormat + " a")
        dateFormatterPrint.amSymbol = ""
        dateFormatterPrint.pmSymbol = ""
        dateFormatterPrint.locale = Locale.current
        dateFormatterPrint.timeZone = .current
        dateFormatterPrint.dateFormat = dateFormat
        let dateFormatted = dateFormatterPrint.string(from: self)
        return dateFormatted
    }
}
