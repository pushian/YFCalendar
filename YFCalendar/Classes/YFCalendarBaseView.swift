//
//  CalendarBaseView.swift
//  Calendar
//
//  Created by Yangfan Liu on 23/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFCalendarBaseView: UIView {
    let yearUnit = NSCalendarUnit.Year
    let monthUnit = NSCalendarUnit.Month
    let dayUnit = NSCalendarUnit.Day
    let hourUnit = NSCalendarUnit.Hour
    let minUnit = NSCalendarUnit.Minute
    let secondUnit = NSCalendarUnit.Second
    let weekUnit = NSCalendarUnit.WeekOfMonth
    let weekdayUnit = NSCalendarUnit.Weekday
    let calendar = NSCalendar.currentCalendar()
}

extension NSDate {
    func YFStandardFormatDate() -> NSDate {
        let unit = NSCalendarUnit.Year.union(NSCalendarUnit.Month).union(NSCalendarUnit.Day).union(NSCalendarUnit.Weekday)
        let components = NSCalendar.currentCalendar().components(unit, fromDate: self)
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    func YFComponentsYear() -> Int {
        let unit = NSCalendarUnit.Year
        let components = NSCalendar.currentCalendar().components(unit, fromDate: self)
        return components.year
    }
    func YFComponentsMonth() -> Int {
        let unit = NSCalendarUnit.Month
        let components = NSCalendar.currentCalendar().components(unit, fromDate: self)
        return components.month
    }
    func YFComponentsDay() -> Int {
        let unit = NSCalendarUnit.Day
        let components = NSCalendar.currentCalendar().components(unit, fromDate: self)
        return components.day
    }
}
