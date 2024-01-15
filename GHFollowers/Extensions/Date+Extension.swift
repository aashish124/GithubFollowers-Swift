//
//  Date+Extension.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 15/01/24.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYYMMM")
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
