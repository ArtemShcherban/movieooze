//
//  DateFormat.swift
//  Movieooze
//
//  Created by Artem Shcherban on 11.09.2021.
//

import Foundation

struct DateFormat {
    static func dateFormatYear(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "yyyy"
       
        if let date = dateFormatterGet.date(from: date) {
            return    dateFormatterSet.string(from: date)
        } else {
            return ""
        }
    }
    
static  func dateFormatDDMMYY(date: String) -> String {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "dd.MM.yyyy"
       
        if let date = dateFormatterGet.date(from: date) {
            return    dateFormatterSet.string(from: date)
        } else {
            return " "
        }
    }
}
