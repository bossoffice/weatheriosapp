//
//  dateFormatter.swift
//  WeatherApp
//
//  Created by gable006973 on 23/3/2566 BE.
//

import Foundation


enum FormatDateTime: String {
    case normal = "yyyy-MM-dd HH:mm:ss"
    case short = "yyyy-MM-dd"
    case shortTime = "HH:mm"
    case movieRelease = "MMMM d, yyyy"
}

func convertToDate(str: String ,format: FormatDateTime = .normal) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    let returnValue = formatter.date(from: str)
    return returnValue
}

func convertToString(date: Date ,format: FormatDateTime = .normal) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.locale = Locale(identifier: "EN")
    let returnValue = formatter.string(from: date)
    return returnValue
}

func reformFormStringArrayWithFlatMap() {
    
}


