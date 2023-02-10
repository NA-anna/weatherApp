//
//  Date+extensions.swift
//  weatherApp
//
//  Created by 나유진 on 2023/02/10.
//

import Foundation


//===========================================================================================
// Date <-> String
//===========================================================================================
extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    

}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEE"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toDayKR() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "ko-kr")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func dtToWeekend(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(from: self)
    }
    
    func dtToTimeWithLetter(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h시"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(from: self)
    }
    
    func curretTime(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(from: self)
    }
    
    func timeForBackground(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(from: self)
    }
}
