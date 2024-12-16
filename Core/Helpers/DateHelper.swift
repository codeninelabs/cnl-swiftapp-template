//
//  DateHelper.swift
//  <project_name>
//
//  Created by Kevin Armstrong on 12/5/24.
//


import Foundation

class DateHelper {
    static func addDays(_ date: Date, days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }

    static func addWeeks(_ date: Date, weeks: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: weeks * 7, to: date) ?? date
    }

    static func addMonths(_ date: Date, months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: date) ?? date
    }

    static func addYears(_ date: Date, years: Int) -> Date {
        Calendar.current.date(byAdding: .year, value: years, to: date) ?? date
    }

    static func shortDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let currentYear = Calendar.current.component(.year, from: Date())
        let dateYear = Calendar.current.component(.year, from: date)
        
        if currentYear == dateYear {
            dateFormatter.dateFormat = "EEEE, MMMM dd"
        } else {
            dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        }
        
        return dateFormatter.string(from: date)
    }
    
    static func todayOffsetDisplay(date: Date) -> String {
        let today = Calendar.current.startOfDay(for: Date())
        let targetDate = Calendar.current.startOfDay(for: date)
        let components = Calendar.current.dateComponents([.day], from: today, to: targetDate)
        
        guard let daysDifference = components.day else {
            return "Invalid date"
        }

        switch daysDifference {
        case -7:
            return "A week ago"
        case -6:
            return "6 days ago"
        case -5:
            return "5 days ago"
        case -4:
            return "4 days ago"
        case -3:
            return "3 days ago"
        case -2:
            return "2 days ago"
        case -1:
            return "Yesterday"
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        case 2:
            return "In 2 days"
        case 3:
            return "In 3 days"
        case 4, 5, 6:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return "This \(dateFormatter.string(from: targetDate))"
        case 7:
            return "In a week"
        default:
            return shortDate(date: date)
        }
    }
    
    static func dateFromString(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: string) ?? Date.now
        return date
    }
}
