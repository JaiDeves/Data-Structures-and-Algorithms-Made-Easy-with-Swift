//
//  Date Extension.swift
//  GetAFixMD
//
//  Created by Mobileapptelligence India on 04/09/17.
//  Copyright © 2017 Mobileapptelligence India. All rights reserved.
//

import Foundation

extension Date {
    static var dateFormatter = DateFormatter()
    
    var gregorian:Calendar{
        return Calendar(identifier: Calendar.Identifier.gregorian)
    }
    
    func isBigger(_ to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedDescending ? true : false
    }
    
    func isSmaller(_ to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedAscending ? true : false
    }
    
    //..pls read isDate() description
    func isDayWith(in _date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: _date)
    }
    
    func isEqual(_ to: Date)->Bool{
        let df = Date.dateFormatter
        df.dateFormat = "yyyy-mm-dd"
        if  df.string(from: self) == df.string(from: to){
            return true
        }
        return false
    }
    
    func isElement(_ of: [Date]) -> Bool {
        for element in of {
            if self.isEqual(element) {
                return true
            }
        }
        return false
    }
    
    
    func isInRange(_ fromDate:Date,toDate:Date)->Bool{
        return (fromDate...toDate).contains(Date())
    }
    
    
    func stringFrom(_ format:String = "yyyy-MM-dd")->String{
        Date.dateFormatter.dateFormat = format
        return Date.dateFormatter.string(from: self)
    }
    
    static func dateFrom(_ format:String = "yyyy-MM-dd",strDate:String)->Date?{
        Date.dateFormatter.dateFormat = format
        return Date.dateFormatter.date(from: strDate)
    }
    
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of days from another date
    func nights(from date: Date) -> Int {
        let difference =  Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
        let nights = difference / 1000 * 3600 * 24
        return Int(nights)
    }
    
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    
    func addDateComponet(_ component:RJDateComponents,value:Int)->Date?{
        var dateComponet:DateComponents = DateComponents()
        switch component {
        case .day:
            dateComponet.day = value
            break
        case .month:
            dateComponet.month = value
            break
        case .year:
            dateComponet.year = value
            break
        default:
            break
        }
        let afterDate =  gregorian.date(byAdding: dateComponet, to: self)
        return afterDate
    }
    
    static func utcToLocal(date:String,dateFormat:String) -> Date? {
        print("given date ",date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = NSCalendar.current
        
        if let convertedDate = dateFormatter.date(from: date){
            print(convertedDate)
            let localDateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.dateFormat = localDateFormat
            let localDateString = dateFormatter.string(from: convertedDate)
            print("converted date str",localDateString)
            let localDate = dateFormatter.date(from: localDateString)
            print("converted date ",localDate)
//                Date.dateFrom(localDateFormat, strDate: localDateString)
            return localDate
        }
        return nil
    }
    
    func localToUTC(date:String,dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let dt = dateFormatter.date(from: date){
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let utcDateString = dateFormatter.string(from: dt)
            return dateFormatter.date(from: utcDateString)
        }
        return nil
    }
    
        static func ISOStringFromDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            
            return dateFormatter.string(from: date).appending("Z")
        }
        
        static func dateFromISOString(string: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            return dateFormatter.date(from: string)
        }
    
}

enum RJDateComponents {
    case second
    case minute
    case day
    case month
    case year
}


func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}


extension Date{
    func currentTimestampOffset(from date:Date)->String{
        let minutes = self.minutes(from: date)
        if minutes < 60 { return "\(minutes) mins" }
        let hours = self.hours(from: date)
        if hours < 24 { return "\(hours) hours"   }
        let days = self.days(from: date)
        return "\(days) days"
    }
}

