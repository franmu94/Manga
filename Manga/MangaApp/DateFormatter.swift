//
//  DateFormatter.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation

extension DateFormatter {
    static let dateFormatCustom = {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return date
    }()
    static var dateFormatCustom2: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return date
    }
}
