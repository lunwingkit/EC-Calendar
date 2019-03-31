//
//  Calendar.swift
//  Project1
//
//  Created by Sampoison on 11/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import Foundation

class Custom_Calender {
    
    static func getMonthStringFromInt(int: Int) -> String {
        
        switch(int){
            
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "ERR"
        }
        
    }
    
}

class Normal_Calender: Custom_Calender {
    
    static func getMonth(year: Int, month: Int) -> Month {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateString = String(year) + "-" + String(month) + "-1"
        let date = formatter.date(from: dateString)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: -8 * 3600)!
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
    
    static func getDayByDayOfWeek(year: Int, month: Int, dayofWeek: Int, dayofWeekIndex: Int) -> String {
        
        let targetMonth = Normal_Calender.getMonth(year: year, month: month)
        
        var dow: Int = targetMonth.startingWeekDay;
        var dowIndex: Int = 0;
        
        for i in 1..<targetMonth.daysInMonth {
            
            if(dow == dayofWeek && dowIndex == dayofWeekIndex) {
                
                var dowString: String;
                
                switch(dow) {
                case 1:
                    dowString = "Monday"
                case 2:
                    dowString = "Tuesday"
                case 3:
                    dowString = "Wednesday"
                case 4:
                    dowString = "Thursday"
                case 5:
                    dowString = "Friday"
                case 6:
                    dowString = "Saturday"
                case 7:
                    dowString = "Sunday"
                default:
                    dowString = "This should not happen"
                }
                
                return "\(year)-\(month)-\(i), \(dowString)"
                
            }
            
            dow += 1;
            
            if(dow > 7) {
                dowIndex += 1;
                dow = 1;
            }
            
        }
        
        return "Not Found"
        
    }
    
    static func getDay(year: Int, month: Int, day: Int) -> String {
        
        let targetMonth = Normal_Calender.getMonth(year: year, month: month)
        
        var dow: Int = (day + targetMonth.startingWeekDay - 2) % 7 + 1;
        
        var dowString: String;
        
        switch(dow) {
        case 1:
            dowString = "Monday"
        case 2:
            dowString = "Tuesday"
        case 3:
            dowString = "Wednesday"
        case 4:
            dowString = "Thursday"
        case 5:
            dowString = "Friday"
        case 6:
            dowString = "Saturday"
        case 7:
            dowString = "Sunday"
        default:
            dowString = "This should not happen"
        }
        
        return "\(year)-\(month)-\(day), \(dowString)"
        
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
    
    static func getDayByDayOfWeek(year: Int, month: Int, dayofWeek: Int, dayofWeekIndex: Int) -> String {
        
        let targetMonth = EC_Calendar.getMonth(year: year, month: month)
        
        var dow: Int = targetMonth.startingWeekDay;
        var dowIndex: Int = 0;
        
        for i in 1..<targetMonth.daysInMonth {
            
            if(dow == dayofWeek && dowIndex == dayofWeekIndex) {
                
                var dowString: String;
                
                switch(dow) {
                case 1:
                    dowString = "Monday"
                case 2:
                    dowString = "Tuesday"
                case 3:
                    dowString = "Wednesday"
                case 4:
                    dowString = "Thursday"
                case 5:
                    dowString = "Friday"
                case 6:
                    dowString = "Saturday"
                case 7:
                    dowString = "Sunday"
                default:
                    dowString = "This should not happen"
                }
                
                return "\(year)-\(month)-\(i), \(dowString)"
                
            }
            
            dow += 1;
            
            if(dow > 7) {
                dowIndex += 1;
                dow = 1;
            }
            
        }
        
        return "Not Found"
        
    }
    
    static func getDay(year: Int, month: Int, day: Int) -> String {
        
        let targetMonth = EC_Calendar.getMonth(year: year, month: month)
        
        var dow: Int = (day + targetMonth.startingWeekDay - 2) % 7 + 1;
        
        var dowString: String;
        
        switch(dow) {
        case 1:
            dowString = "Monday"
        case 2:
            dowString = "Tuesday"
        case 3:
            dowString = "Wednesday"
        case 4:
            dowString = "Thursday"
        case 5:
            dowString = "Friday"
        case 6:
            dowString = "Saturday"
        case 7:
            dowString = "Sunday"
        default:
            dowString = "This should not happen"
        }
        
        return "\(year)-\(month)-\(day), \(dowString)"
        
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
