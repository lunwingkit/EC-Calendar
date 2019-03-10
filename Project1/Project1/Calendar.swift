//
//  Calendar.swift
//  Project1
//
//  Created by Sampoison on 11/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import Foundation

class Custom_Calender {
    
}

class Normal_Calender: Custom_Calender {
    
    static func getMonth(year: Int, month: Int) -> Month {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        let dateString = String(year) + "-" + String(month) + "-1"
        let date = formatter.date(from: dateString)
        let calendar = Calendar(identifier: .gregorian)
        let startingWeekDay = calendar.component(.weekday, from: date!)
        
        let isLeapYear = year % 4 == 0
        let daysInMonth: Int;
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            daysInMonth = 31
        case 4, 6, 9, 11:
            daysInMonth = 30
        case 2:
            daysInMonth = isLeapYear ? 29 : 28
        default:
            daysInMonth = -1
        }
        
        return Month(daysInMonth: daysInMonth, startingWeekDay: startingWeekDay)
        
    }
    
}

class EC_Calendar: Custom_Calender {
    
    static func getMonth(year: Int, month: Int) -> Month {
        
        let startingWeekDay: Int
        
        switch month {
        case 1:
            startingWeekDay = 1
        case 2:
            startingWeekDay = 4
        case 3, 6, 12:
            startingWeekDay = 5
        case 4, 7, 10:
            startingWeekDay = 7
        case 5:
            startingWeekDay = 2
        case 8, 11:
            startingWeekDay = 3
        case 9:
            startingWeekDay = 6
        default:
            startingWeekDay = -1
        }
        
        let isLeapYear = year % 4 == 0
        let daysInMonth: Int;
        
        switch month {
        case 1, 5, 7, 8, 10, 12:
            daysInMonth = 31
        case 4, 6, 9, 11:
            daysInMonth = 30
        case 2:
            daysInMonth = 29
        case 3:
            daysInMonth = isLeapYear ? 31 : 30
        default:
            daysInMonth = -1
        }
        
        return Month(daysInMonth: daysInMonth, startingWeekDay: startingWeekDay)
        
    }
    
}

class Month {
    
    var daysInMonth: Int;
    var startingWeekDay: Int;
    
    init(daysInMonth: Int, startingWeekDay: Int) {
        
        self.daysInMonth = daysInMonth;
        self.startingWeekDay = startingWeekDay;
        
    }
    
}
