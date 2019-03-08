import Foundation

class EC_Calendar {
    
    var year: [Month];
    
    init(year: Int) {
        
        let isLeapYear = year % 4 == 0;
        
        let January = Month(daysInMonth: 31, startingDayOfWeek: 0);
        let Febuary = Month(daysInMonth: 29, startingDayOfWeek: 3);
        let March = Month(daysInMonth: isLeapYear ? 31 : 30, startingDayOfWeek: 4);
        let April = Month(daysInMonth: 30, startingDayOfWeek: 6);
        let May = Month(daysInMonth: 31, startingDayOfWeek: 1);
        let June = Month(daysInMonth: 30, startingDayOfWeek: 4);
        let July = Month(daysInMonth: 31, startingDayOfWeek: 6);
        let August = Month(daysInMonth: 31, startingDayOfWeek: 2);
        let September = Month(daysInMonth: 30, startingDayOfWeek: 5);
        let October = Month(daysInMonth: 31, startingDayOfWeek: 6);
        let November = Month(daysInMonth: 30, startingDayOfWeek: 2);
        let December = Month(daysInMonth: 31, startingDayOfWeek: 4);
        
        self.year = [January, Febuary, March, April, May, June, July, August, September, October, November, December];
        
    }
    
    func getDayOfWeek(month: Int, day: Int) -> Int {
        
        return (day + self.year[month].startingDayOfWeek) % 7;
        
    }
    
    func printYear() -> Void {
        
        for month in 0..<12 {
            
            for day in 0..<self.year[month].daysInMonth {
                
                let dayOfWeek = self.getDayOfWeek(month: month, day: day);
                let dayOfWeekString: String;
                
                switch dayOfWeek {
                    case 0:
                        dayOfWeekString = "Monday"
                    case 1:
                        dayOfWeekString = "Tuesday"
                    case 2:
                        dayOfWeekString = "Wednesday"
                    case 3:
                        dayOfWeekString = "Thursady"
                    case 4:
                        dayOfWeekString = "Friday"
                    case 5:
                        dayOfWeekString = "Saturday"
                    case 6:
                        dayOfWeekString = "Sunday"
                    default:
                        dayOfWeekString = "Something Weird Happened"
                }
                
                print("\(month + 1)-\(day + 1): \(dayOfWeekString)");
                
            }
            
        }
        
    }
    
}

class Month {
    
    var daysInMonth: Int;
    var startingDayOfWeek: Int;
    
    init(daysInMonth: Int, startingDayOfWeek: Int) {
        
        self.daysInMonth = daysInMonth;
        self.startingDayOfWeek = startingDayOfWeek;
        
    }
    
}
