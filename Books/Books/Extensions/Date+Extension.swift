//
//  Date+Extension.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 05/06/23.
//

import Foundation

enum DateFormat: String {
    case yyyyMMddTTHHmmSSSZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yyyyMMdd = "yyyy-MM-dd"
}

extension Date {
    func getDateString(format: String? = nil) -> String {
        let dateFormat = format ?? DateFormat.yyyyMMddTTHHmmSSSZ.rawValue
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
