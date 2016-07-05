//
//  MonthView.swift
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFMonthView: YFCalendarBaseView {
    //MARK: - Weak Reference
    unowned let calendarView: YFCalendarView
    unowned let appearance: YFCalendarAppearance

    //MARK: - Functions Open For User
    //MARK: - Public Functions
//    func updateFrame() {
//        frame.size.height = CGFloat(numberOfWeeks()) * appearance.weekHeight
//        interActiveView.frame.size.height = frame.height
//    }
    
    func numberOfWeeks() -> Int {
        let range = calendar.rangeOfUnit(weekUnit, inUnit: monthUnit, forDate: aDayInTheMonth!)
        return range.length
    }
    func didTapOnTheView(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(self.interActiveView)
        let owner: YFDayView? = findTheOwnerWithLocation(location)
        if let owner = owner where owner.hidden != true {
            tapActionOnADay(owner, completion: { 
                if owner.isSelected! {
                    self.calendarView.calendarViewDelegate?.calendarView?(self.calendarView, didSelectADay: owner)
                } else {
                    self.calendarView.calendarViewDelegate?.calendarView?(self.calendarView, didDeselectADay: owner)
                }
            })
        }
    }
    
    func tapActionOnADay(var day: YFDayView, completion: (() -> Void)?) {
        if let disable = appearance.delegate?.calendarView?(calendarView, disableUserInteractionForTheDay: day) {
            if disable {
            } else {
                var theSameDay: YFDayView?
                if !day.isInside! {
                    if day.date?.timeIntervalSince1970 > aDayInTheMonth?.timeIntervalSince1970 {
                        if calendarView.autoScrollToTheNewMonth {
                            calendarView.presentNextMonth(withSelectedDate: true)
                        }
                        theSameDay = calendarView.threeMonths[2].weekViews[0].findTheOwnerWithDate(day.date!)
                    } else {
                        if calendarView.autoScrollToTheNewMonth {
                            calendarView.presentPreviousMonth(withSelectedDate: true)
                        }
                        theSameDay = calendarView.threeMonths[0].weekViews[calendarView.threeMonths[0].numberOfWeeks() - 1].findTheOwnerWithDate(day.date!)
                    }
                } else {
                    if day.weekView.weekIndex == 1 {
                        theSameDay = calendarView.threeMonths[0].weekViews[calendarView.threeMonths[0].numberOfWeeks() - 1].findTheOwnerWithDate(day.date!)
                    } else if day.weekView.weekIndex == day.weekView.monthView.numberOfWeeks() {
                        theSameDay = calendarView.threeMonths[2].weekViews[0].findTheOwnerWithDate(day.date!)
                    }
                }
                
                switch calendarView.dateSelectionMode {
                case .Single:
                    for index in 0..<calendarView.selectedDayViews.count where calendarView.selectedDayViews.count > 0 {
                        if calendarView.selectedDayViews[index].date != day.date {
                            calendarView.selectedDayViews[index].isSelected = false
                        }
                    }
                    calendarView.selectedDayViews.removeAll()
                    calendarView.selectedDates.removeAll()
                    calendarView.selectedDayViews.append(day)
                    calendarView.selectedDates.append(day.date!)
                    if let theSameDay = theSameDay {
                        calendarView.selectedDayViews.append(theSameDay)
                    }
                    if let theSameDay = theSameDay {
                        if day.isInside! {
                            theSameDay.isSelected = true
                            day.isSelected = true
                        } else {
                            day.isSelected = true
                            theSameDay.isSelected = true
                        }
                    } else {
                        day.isSelected = true
                    }
                case .Multiple:
                    if let selected = day.isSelected {
                        if selected {
                            calendarView.selectedDayViews.removeAtIndex(calendarView.selectedDayViews.indexOf(day)!)
                            calendarView.selectedDates.removeAtIndex(calendarView.selectedDates.indexOf(day.date!)!)
                            if let theSameDay = theSameDay {
                                calendarView.selectedDayViews.removeAtIndex(calendarView.selectedDayViews.indexOf(theSameDay)!)
                            }
                        } else {
                            calendarView.selectedDayViews.append(day)
                            calendarView.selectedDates.append(day.date!)
                            if let theSameDay = theSameDay {
                                calendarView.selectedDayViews.append(theSameDay)
                            }
                        }
                        if let theSameDay = theSameDay {
                            if day.isInside! {
                                theSameDay.isSelected = !selected
                                day.isSelected = !selected
                            } else {
                                day.isSelected = !selected
                                theSameDay.isSelected = !selected
                            }
                        } else {
                            day.isSelected = !selected
                        }
                    } else {
                        calendarView.selectedDayViews.append(day)
                        calendarView.selectedDates.append(day.date!)
                        if let theSameDay = theSameDay {
                            calendarView.selectedDayViews.append(theSameDay)
                        }
                        if let theSameDay = theSameDay {
                            if day.isInside! {
                                theSameDay.isSelected = true
                                day.isSelected = true
                            } else {
                                day.isSelected = true
                                theSameDay.isSelected = true
                            }
                        } else {
                            day.isSelected = true
                        }
                    }
                    
                }
            }
        }
        if let completion = completion {
            completion()
        }
    }
    
    func findTheOwnerWithDate(date: NSDate) -> YFDayView? {
        for week in weekViews {
            for day in week.dayViews {
                if day.belongsToDate(date) {
                    return day
                }
            }
        }
        return nil
    }

    //MARK: - Private Functions
    private func loadWeeks() {
        for index in 1...numberOfWeeks() {
            insertWeek(index)
        }
    }
    
    private func insertWeek(index: Int) {
        let weekFrame = CGRectMake(0, calendarView.appearance!.weekHeight * CGFloat(index - 1), frame.width, calendarView.appearance!.weekHeight)
        let weekView = YFWeekView(monthView: self, frame: weekFrame, weekIndex: index)
        addSubview(weekView)
        weekViews.append(weekView)
    }
    
    private func checkDays() {
        let unit = yearUnit.union(monthUnit).union(dayUnit).union(weekdayUnit)
        var components = calendar.components(unit, fromDate: aDayInTheMonth!)
        components.day = 1
        let startDay = calendar.dateFromComponents(components)
        components.month += 1
        components.day -= 1
        let endDay = calendar.dateFromComponents(components)
        var theDate = startDay
        addToInsideDataBase(theDate!)
        repeat {
            theDate = calendar.dateByAddingUnit(.Day, value: 1, toDate: theDate!, options: NSCalendarOptions(rawValue: 0))
            addToInsideDataBase(theDate!)
        } while !(theDate!.isEqualToDate(endDay!))
        
        let startComponents = calendar.components(unit, fromDate: startDay!)
        let endComponents = calendar.components(unit, fromDate: endDay!)
        
        if startComponents.weekday != 1 {
            theDate = startDay
            for _ in 1..<startComponents.weekday {
                theDate = calendar.dateByAddingUnit(.Day, value: -1, toDate: theDate!, options: NSCalendarOptions(rawValue: 0))
                addToOutsideDataBase(theDate!, weekIndex: 1)
            }
        }
        if endComponents.weekday != 7 {
            theDate = endDay
            for _ in 1...(7 - endComponents.weekday) {
                theDate = calendar.dateByAddingUnit(.Day, value: 1, toDate: theDate!, options: NSCalendarOptions(rawValue: 0))
                addToOutsideDataBase(theDate!, weekIndex: numberOfWeeks())
            }
        }
    }
    
    private func addToInsideDataBase(date: NSDate) {
        let unit = yearUnit.union(monthUnit).union(dayUnit).union(weekUnit).union(weekdayUnit)
        let components = calendar.components(unit, fromDate: date)
        let theDay = components.weekday
        let theWeek = components.weekOfMonth
        if let dateOnWeek = daysInsideTheMonth[theWeek] {
            if let _ = dateOnWeek[theDay] {
            } else {
                (daysInsideTheMonth[theWeek])![theDay] = date
            }
        } else {
            let item1: [Day: NSDate] = [theDay: date]
            daysInsideTheMonth[theWeek] = item1
        }
    }
    
    private func addToOutsideDataBase(date: NSDate, weekIndex: Int) {
        let unit = yearUnit.union(monthUnit).union(dayUnit).union(weekUnit).union(weekdayUnit)
        let components = calendar.components(unit, fromDate: date)
        let theDate = components.day
        let theDay = components.weekday
        let theWeek = weekIndex
        if let dateOnWeek = daysOutsideTheMonth[theWeek] {
            if let _ = dateOnWeek[theDay] {
            } else {
                (daysOutsideTheMonth[theWeek])![theDay] = date
            }
        } else {
            let item1: [Day: NSDate] = [theDay: date]
            daysOutsideTheMonth[theWeek] = item1
        }
    }
    
    private func findTheOwnerWithLocation(location: CGPoint) -> YFDayView? {
        for week in weekViews {
            let weekIndex = week.weekIndex!
            for day in week.dayViews {
                let dayIndex = day.dayIndex!
                if location.x >= appearance.dayWidth * CGFloat(dayIndex - 1) && location.x < appearance.dayWidth * CGFloat(dayIndex) && location.y >= appearance.weekHeight * CGFloat(weekIndex - 1) && location.y < appearance.weekHeight * CGFloat(weekIndex){
                    return day
                }
            }
        }
        return nil
    }
    
    //MARK: - Variables Open For User
    public var currentYear: Int? {
        get {
            return components?.year
        }
    }
    
    public var currentMonth: Int? {
        get {
            return components?.month
        }
    }
    //MARK: - Public Variables
    typealias Week = Int
    typealias Day = Int
    var components: NSDateComponents?
    var daysInsideTheMonth = [Week: [Day: NSDate]]()
    var daysOutsideTheMonth = [Week: [Day: NSDate]]()
    var monthIndex: Int!
    var weekViews = [YFWeekView]()
    var aDayInTheMonth: NSDate? {
        didSet {
            let unit = yearUnit.union(monthUnit)
            components = calendar.components(unit, fromDate: aDayInTheMonth!)
            checkDays()
            loadWeeks()
            addSubview(interActiveView)
//            updateFrame()
        }
    }
    
    //MARK: - Private Variables
    private var interActiveView: UIView! = {
        let t = UIView()
        t.backgroundColor = UIColor.clearColor()
        return t
    }()
    
    
    //MARK: - Life Cycle
    init(calendarView: YFCalendarView, frame: CGRect, monthIndex: Int) {
        self.calendarView = calendarView
        self.appearance = self.calendarView.appearance!
        self.monthIndex = monthIndex
        super.init(frame: frame)
        interActiveView.frame = self.bounds
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTapOnTheView(_:)))
        interActiveView.addGestureRecognizer(gesture)
        backgroundColor = UIColor.whiteColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
