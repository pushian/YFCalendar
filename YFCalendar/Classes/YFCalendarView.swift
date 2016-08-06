//
//  CalendarView.swift
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

//MARK: - Functions Open For User
extension YFCalendarView {
    /**
    Add small dots under the date label with customized colors. The old dots will be remained.
    */
    public func addDotsToDate(date: NSDate, dotColorArrays: [UIColor]) {
        for index in 0..<3 {
            if let day = threeMonths[index].findTheOwnerWithDate(date) {
                day.addDots(dotColorArrays)
            }
        }
        var dotedDate = DotedDate()
        dotedDate.date = date.YFStandardFormatDate()
        
        for index in (0..<dotedDates.count) {
            if dotedDates[index].equalsTo(dotedDate) {
                dotedDates[index].dotColors!.appendContentsOf(dotColorArrays)
                return
            }
        }
        dotedDate.dotColors = dotColorArrays
        dotedDates.append(dotedDate)
    }
    /**
    Remove all the old dots under the date label and add new dots with customized colors.
    */
    public func updateDotsToDate(date: NSDate, dotColorArrays: [UIColor]) {
        for index in 0..<3 {
            if let day = threeMonths[index].findTheOwnerWithDate(date) {
                day.updateDotView(dotColorArrays)
            }
        }
        
        var dotedDate = DotedDate()
        dotedDate.date = date.YFStandardFormatDate()
        dotedDate.dotColors = dotColorArrays
        
        if dotColorArrays.count > 0 {
            for index in (0..<dotedDates.count) {
                if dotedDates[index].equalsTo(dotedDate) {
                    dotedDates[index] = dotedDate
                    return
                }
            }
            dotedDates.append(dotedDate)
        } else {
            dotedDates = dotedDates.filter { !$0.equalsTo(dotedDate) }
        }
    }
    /**
     Remove all the old dots for a specific date.
     */
    public func removeDotFromDate(date: NSDate) {
        updateDotsToDate(date, dotColorArrays: [UIColor]())
    }
    /**
     Clear all the selections.
     */
    public func clearAllSelection() {
        for each in selectedDayViews {
            each.isSelected = false
        }
        selectedDayViews.removeAll()
        selectedDates.removeAll()
    }
    /**
     A tap action will be triggered on the specific date.
     */
    public func sendTapToADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
        let components = calendar.components(unit, fromDate: date)
        if components == presentedMonthView?.components {
            let dayView = presentedMonthView?.findTheOwnerWithDate(date)
            presentedMonthView?.tapActionOnADay(dayView!, completion: nil)
        } else {
            if selectedDates.contains(date.YFStandardFormatDate()) {
                selectedDates.removeAtIndex(selectedDates.indexOf(date.YFStandardFormatDate())!)
                initialLoad(date, autoSelect: false)
            } else {
                initialLoad(date, autoSelect: true)
            }
        }
    }
    /**
     Select today and the view will also be switched to the current month.
     */
    public func selectToday() {
        selectADate(NSDate())
    }
    /**
     Select a specific date.
     */
    public func selectADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
        let components = calendar.components(unit, fromDate: date)
        switch dateSelectionMode {
        case .Single:
            if components == presentedMonthView?.components {
                let dayView = presentedMonthView?.findTheOwnerWithDate(date)
                presentedMonthView?.tapActionOnADay(dayView!, completion: nil)
            } else {
                initialLoad(date, autoSelect: true)
            }
        case .Multiple:
            if selectedDates.contains(date.YFStandardFormatDate()) {
                if components == presentedMonthView?.components {
                } else {
                    initialLoad(date, autoSelect: false)
                }
            } else {
                if components == presentedMonthView?.components {
                    let dayView = presentedMonthView?.findTheOwnerWithDate(date)
                    presentedMonthView?.tapActionOnADay(dayView!, completion: nil)
                } else {
                    initialLoad(date, autoSelect: true)
                }
            }
        }
    }
    /**
     Deselect a specific date.
     */
    public func deselectADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
//        let components = calendar.components(unit, fromDate: date)
        switch dateSelectionMode {
        case .Single:
            if selectedDates.contains(date.YFStandardFormatDate()) {
                clearAllSelection()
            }
        case .Multiple:
            if selectedDates.contains(date.YFStandardFormatDate()) {
                for each in threeMonths {
                    if let day = each.findTheOwnerWithDate(date) {
                        day.isSelected = false
                        selectedDayViews.removeAtIndex(selectedDayViews.indexOf(day)!)
                    }
                }
                selectedDates.removeAtIndex(selectedDates.indexOf(date.YFStandardFormatDate())!)
            }
        }
    }
    /**
     Present the previous month.
     */
    public func presentPreviousMonth(withSelectedDate withSelectedDate: Bool = false) {
        if pageLoadingEnabled {
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]
            
            self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[0])
            UIView.animateWithDuration(0.5, delay: 0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        if self.calendarScrollDirection == .Horizontal {
                                            current.frame.origin.x += self.frame.width
                                            previous.frame.origin.x += self.frame.width
                                        } else {
                                            current.frame.origin.y += self.frame.height
                                            previous.frame.origin.y += self.frame.height
                                        }
            }) { _ in
                next.removeFromSuperview()
                self.clearSelectedDayViews(ofMonthView: next)
                self.threeMonths[2] = self.threeMonths[1]
                self.threeMonths[1] = self.threeMonths[0]
                self.presentedMonthView = self.threeMonths[1]
                if !withSelectedDate && self.dateSelectionMode == .Single && self.autoSelectTheDayForMonthSwitchInTheSingleMode {
                    if self.presentedMonthView?.components?.year == NSDate().YFComponentsYear() && self.presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                        self.selectADate(NSDate())
                    } else {
                        self.selectADate(self.firstDateOfPreviouMonth!)
                    }
                }
                let newMonth = YFMonthView(calendarView: self, monthIndex: 0)
                self.aDateOfCurrentMonth = self.firstDateOfPreviouMonth
                newMonth.aDayInTheMonth = self.firstDateOfPreviouMonth
                self.threeMonths[0] = newMonth
                self.scrollView.addSubview(newMonth)
                self.setConstrains()
                self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
                self.dotDotedDayViews(inMonthView: newMonth)
                self.calendarViewDelegate?.calendarView?(self, didPresentTheMonth: self.presentedMonthView!)
                self.pageLoadingEnabled = true
            }
        }
    }
    /**
     Present the next month.
     */
    public func presentNextMonth(withSelectedDate withSelectedDate: Bool = false) {
        if pageLoadingEnabled {
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]
            
            self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[2])
            UIView.animateWithDuration(0.5, delay: 0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        if self.calendarScrollDirection == .Horizontal {
                                            current.frame.origin.x -= self.frame.width
                                            next.frame.origin.x -= self.frame.width
                                        } else {
                                            current.frame.origin.y -= self.frame.height
                                            next.frame.origin.y -= self.frame.height
                                        }
            }) { _ in
                previous.removeFromSuperview()
                self.clearSelectedDayViews(ofMonthView: previous)
                self.threeMonths[0] = self.threeMonths[1]
                self.threeMonths[1] = self.threeMonths[2]
                self.presentedMonthView = self.threeMonths[1]
                if !withSelectedDate && self.dateSelectionMode == .Single && self.autoSelectTheDayForMonthSwitchInTheSingleMode {
                    if self.presentedMonthView?.components?.year == NSDate().YFComponentsYear() && self.presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                        self.selectADate(NSDate())
                    } else {
                        self.selectADate(self.firstDateOfNextMonth!)
                    }
                }
                let newMonth = YFMonthView(calendarView: self, monthIndex: 2)
                self.aDateOfCurrentMonth = self.firstDateOfNextMonth
                newMonth.aDayInTheMonth = self.firstDateOfNextMonth
                self.threeMonths[2] = newMonth
                self.scrollView.addSubview(newMonth)
                self.setConstrains()
                self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
                self.dotDotedDayViews(inMonthView: newMonth)
                self.calendarViewDelegate?.calendarView?(self, didPresentTheMonth: self.presentedMonthView!)
                self.pageLoadingEnabled = true
            }
        }
    }
    /**
     Refresh the calendar view.
     */
    public func reloadCalenderView() {
        initialLoad(aDateOfCurrentMonth!, autoSelect: false)
    }
}

//MARK: - Private Functions
extension YFCalendarView {
    private func clearSelectedDayViews(ofMonthView monthView: YFMonthView) {
        selectedDayViews = selectedDayViews.filter { (day) -> Bool in
            !(day.components?.month == monthView.components!.month && day.isInside!)
        }
    }
    
    private func selectPreviouslySelectedDayViews(inMonthView monthView: YFMonthView) {
        if selectedDates.count > 0 {
            selectedDates = Array(Set(selectedDates))
        }
        for week in monthView.weekViews {
            for day in week.dayViews {
                if selectedDates.contains(day.date!) {
                    day.isSelected = true
                    selectedDayViews.append(day)
                }
            }
        }
    }
    
    private func dotDotedDayViews(inMonthView monthView: YFMonthView) {
        for week in monthView.weekViews {
            for day in week.dayViews {
                for each in dotedDates {
                    if each.date == day.date {
                        day.updateDotView(each.dotColors!)
                    }
                }
            }
        }
    }
    private func scrollToNext() {
        if pageLoadingEnabled {
            debugPrint("scrollToNext")
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]
            replaceMonthView(current, with: next)
            replaceMonthView(previous, with: current)
            previous.removeFromSuperview()
            self.clearSelectedDayViews(ofMonthView: previous)
            
            threeMonths[0] = threeMonths[1]
            threeMonths[1] = threeMonths[2]
            self.presentedMonthView = self.threeMonths[1]
            if calendarScrollDirection == .Horizontal {
                scrollView.contentOffset.x = frame.width
            } else {
                scrollView.contentOffset.y = frame.height
            }
            if self.dateSelectionMode == .Single && autoSelectTheDayForMonthSwitchInTheSingleMode {
                if presentedMonthView?.components?.year == NSDate().YFComponentsYear() && presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                    self.selectADate(NSDate())
                } else {
                    self.selectADate(self.firstDateOfNextMonth!)
                }
            }
            let newMonth = YFMonthView(calendarView: self, monthIndex: 2)
            aDateOfCurrentMonth = firstDateOfNextMonth
            newMonth.aDayInTheMonth = firstDateOfNextMonth
            threeMonths[2] = newMonth
            scrollView.addSubview(threeMonths[2])
            setConstrains()
            self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
            self.dotDotedDayViews(inMonthView: newMonth)
            self.calendarViewDelegate?.calendarView?(self, didPresentTheMonth: self.presentedMonthView!)
            willPrensentFunctionHasBeenCalledFlag = false
            pageLoadingEnabled = true
        }
    }
    
    private func scrollToPrevious() {
        if pageLoadingEnabled {
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]
            replaceMonthView(current, with: previous)
            replaceMonthView(next, with: current)
            next.removeFromSuperview()
            self.clearSelectedDayViews(ofMonthView: next)
            threeMonths[2] = threeMonths[1]
            threeMonths[1] = threeMonths[0]
            self.presentedMonthView = self.threeMonths[1]
            if calendarScrollDirection == .Horizontal {
                scrollView.contentOffset.x = frame.width
            } else {
                scrollView.contentOffset.y = frame.height
            }
            if self.dateSelectionMode == .Single && autoSelectTheDayForMonthSwitchInTheSingleMode {
                if presentedMonthView?.components?.year == NSDate().YFComponentsYear() && presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                    self.selectADate(NSDate())
                } else {
                    self.selectADate(self.firstDateOfPreviouMonth!)
                }
            }
            let newMonth = YFMonthView(calendarView: self, monthIndex: 0)
            aDateOfCurrentMonth = firstDateOfPreviouMonth
            newMonth.aDayInTheMonth = firstDateOfPreviouMonth
            threeMonths[0] = newMonth
            scrollView.addSubview(threeMonths[0])
            setConstrains()
            self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
            self.dotDotedDayViews(inMonthView: newMonth)
            self.calendarViewDelegate?.calendarView?(self, didPresentTheMonth: self.presentedMonthView!)
            willPrensentFunctionHasBeenCalledFlag = false
            pageLoadingEnabled = true
        }
    }
    
    private func replaceMonthView(oldMonth: YFMonthView, with newMonth: YFMonthView) {
        let frameOriginOfOld = oldMonth.frame.origin
        newMonth.frame.origin = frameOriginOfOld
    }
    
    private func loadMonths() {
        insertMonthView(0, date: firstDateOfPreviouMonth!)
        insertMonthView(1, date: aDateOfCurrentMonth!)
        insertMonthView(2, date: firstDateOfNextMonth!)
    }
    
    private func insertMonthView(index: Int, date: NSDate) {
        let monthView = YFMonthView(calendarView: self, monthIndex: index)
        monthView.aDayInTheMonth = date
        threeMonths.append(monthView)
        scrollView.addSubview(monthView)
        selectPreviouslySelectedDayViews(inMonthView: monthView)
        self.dotDotedDayViews(inMonthView: monthView)
    }
    
    private func setConstrains() {
        self.removeConstraints(self.constraints)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Top,
            relatedBy: .Equal, toItem: self, attribute: .Top,
            multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Leading,
            relatedBy: .Equal, toItem: self, attribute: .Leading,
            multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Bottom,
            relatedBy: .Equal, toItem: self, attribute: .Bottom,
            multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Trailing,
            relatedBy: .Equal, toItem: self, attribute: .Trailing,
            multiplier: 1, constant: 0))
        if self.calendarScrollDirection == .Horizontal {
            if threeMonths.count == 3 {
                threeMonths[0].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Top,
                    relatedBy: .Equal, toItem: self, attribute: .Top,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Bottom,
                    relatedBy: .Equal, toItem: self, attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Width,
                    relatedBy: .Equal, toItem: self, attribute: .Width,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Leading,
                    relatedBy: .Equal, toItem: scrollView, attribute: .Leading,
                    multiplier: 1, constant: 0))
                
                threeMonths[1].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Top,
                    relatedBy: .Equal, toItem: self, attribute: .Top,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Bottom,
                    relatedBy: .Equal, toItem: self, attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Width,
                    relatedBy: .Equal, toItem: self, attribute: .Width,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Leading,
                    relatedBy: .Equal, toItem: threeMonths[0], attribute: .Trailing,
                    multiplier: 1, constant: 0))
                
                threeMonths[2].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Top,
                    relatedBy: .Equal, toItem: self, attribute: .Top,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Bottom,
                    relatedBy: .Equal, toItem: self, attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Width,
                    relatedBy: .Equal, toItem: self, attribute: .Width,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Leading,
                    relatedBy: .Equal, toItem: threeMonths[1], attribute: .Trailing,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Trailing,
                    relatedBy: .Equal, toItem: scrollView, attribute: .Trailing,
                    multiplier: 1, constant: 0))
            }
        } else {
            if threeMonths.count == 3 {
                threeMonths[0].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Top,
                    relatedBy: .Equal, toItem: scrollView, attribute: .Top,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Height,
                    relatedBy: .Equal, toItem: self, attribute: .Height,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Trailing,
                    relatedBy: .Equal, toItem: self, attribute: .Trailing,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[0], attribute: .Leading,
                    relatedBy: .Equal, toItem: scrollView, attribute: .Leading,
                    multiplier: 1, constant: 0))
                
                threeMonths[1].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Top,
                    relatedBy: .Equal, toItem: threeMonths[0], attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Height,
                    relatedBy: .Equal, toItem: self, attribute: .Height,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Leading,
                    relatedBy: .Equal, toItem: self, attribute: .Leading,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[1], attribute: .Trailing,
                    relatedBy: .Equal, toItem: self, attribute: .Trailing,
                    multiplier: 1, constant: 0))
                
                threeMonths[2].translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Top,
                    relatedBy: .Equal, toItem: threeMonths[1], attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Height,
                    relatedBy: .Equal, toItem: self, attribute: .Height,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Bottom,
                    relatedBy: .Equal, toItem: scrollView, attribute: .Bottom,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Leading,
                    relatedBy: .Equal, toItem: self, attribute: .Leading,
                    multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: threeMonths[2], attribute: .Trailing,
                    relatedBy: .Equal, toItem: self, attribute: .Trailing,
                    multiplier: 1, constant: 0))
            }
        }
    }
    
    private func rectOf(monthView: YFMonthView) -> CGRect {
        let rect = monthView.frame
        return rect
    }
    private func checkTheSameDay(monthIndex: Int, day: YFDayView) -> YFDayView? {
        if monthIndex == 0 {
            if day.weekView.weekIndex == threeMonths[monthIndex].numberOfWeeks() - 1 {
                return threeMonths[monthIndex + 1].findTheOwnerWithDate(day.date!)
            }
        }
        if monthIndex == 1 {
            if day.weekView.weekIndex == threeMonths[monthIndex].numberOfWeeks() - 1 {
                return threeMonths[monthIndex + 1].findTheOwnerWithDate(day.date!)
            }
            if day.weekView.weekIndex == 0 {
                return threeMonths[monthIndex - 1].findTheOwnerWithDate(day.date!)
            }
        }
        if monthIndex == 2 {
            if day.weekView.weekIndex == 0 {
                return threeMonths[monthIndex - 1].findTheOwnerWithDate(day.date!)
            }
        }
        return nil
    }
}

public class YFCalendarView: YFCalendarBaseView {
    //MARK: - Variables Open For User
    weak public var calendarViewDelegate: YFCalendarViewDelegate? {
        didSet {
            appearance = YFCalendarAppearance(calendarView: self)
            appearance?.delegate = calendarViewDelegate
            if autoSelectToday {
                initialLoad(NSDate(),autoSelect: true)
            } else {
                initialLoad(NSDate(),autoSelect: false)
            }
        }
    }
    
    //MARK: - Public Variables
    var selectedDayViews = [YFDayView]()
    var presentedMonthView: YFMonthView?
    var selectedDates = [NSDate]()
    var dotedDates = [DotedDate]()
    
    //MARK: - Delegate Related Variables
    var calendarScrollDirection: CalendarScrollDirection {
        if let delegate = calendarViewDelegate {
            if let calendarScrollDirection = delegate.calendarViewSetScrollDirection?(self) {
                return calendarScrollDirection
            }
        }
        return .Horizontal
    }
    
    var dateSelectionMode: SelectionMode {
        if let delegate = calendarViewDelegate {
            if let dateSelectionMode = delegate.calendarViewSetDateSelectionMode?(self) {
                return dateSelectionMode
            }
        }
        return .Single
    }

    var turnOnAnimationOnDay: Bool {
        if let delegate = calendarViewDelegate {
            if let turnOnAnimationOnDay = delegate.calendarViewTurnOnSelectionAnimation?(self) {
                return turnOnAnimationOnDay
            }
        }
        return true
    }
    
    var autoSelectTheDayForMonthSwitchInTheSingleMode: Bool {
        if let delegate = calendarViewDelegate {
            if let autoSelectTheDayForMonthSwitchInTheSingleMode = delegate.calendarView?(self, autoSelectTheFirstDateOfTheNewMonth: dateSelectionMode) {
            return autoSelectTheDayForMonthSwitchInTheSingleMode
            }
        }
        return true
    }
    
    var autoScrollToTheNewMonth: Bool {
        if let delegate = calendarViewDelegate {
            if let autoScrollToTheNewMonth = delegate.calendarViewAutoScrollToTheNewMonthWhenTabTheDateOutsideOfTheCurrentMonth?(self) {
                return autoScrollToTheNewMonth
            }
        }
        return true
    }
    
    var autoSelectToday: Bool {
        if let delegate = calendarViewDelegate {
            if let autoSelectToday = delegate.calendarViewAutoSelectToday?(self) {
                return autoSelectToday
            }
        }
        return true
    }
    
    var showDateOutside: Bool {
        if let delegate = calendarViewDelegate {
            if let showDateOutside = delegate.calendarViewShowDateOutsideOfTheCurrentMonth?(self){
                return showDateOutside
            }
        }
        return true
    }
    
    //MARK: - Other Public Variables
    var appearance: YFCalendarAppearance?
    var threeMonths = [YFMonthView]()
    
    //MARK: - Private Variables
    private var firstLoadIsDone = false
    
    private var scrollView: UIScrollView! = {
        let t = UIScrollView()
        t.backgroundColor = UIColor.whiteColor()
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.bounces = false
        t.pagingEnabled = true
        return t
    }()
    
    private var aDateOfCurrentMonth: NSDate?
    private var currentDayView: YFDayView?
    private var pageLoadingEnabled = true

    private var firstDateOfPreviouMonth: NSDate? {
        get {
            let unit = yearUnit.union(monthUnit).union(dayUnit)
            let components = calendar.components(unit, fromDate: aDateOfCurrentMonth!)
            components.day = 1
            components.month -= 1
            let newDate = calendar.dateFromComponents(components)
            if let newDate = newDate {
                return newDate
            } else {
                return aDateOfCurrentMonth
            }
        }
    }
    private var firstDateOfNextMonth: NSDate? {
        get {
            let unit = yearUnit.union(monthUnit).union(dayUnit)
            let components = calendar.components(unit, fromDate: aDateOfCurrentMonth!)
            components.day = 1
            components.month += 1
            let newDate = calendar.dateFromComponents(components)
            if let newDate = newDate {
                return newDate
            } else {
                return aDateOfCurrentMonth
            }
        }
    }
    private var willPrensentFunctionHasBeenCalledFlag = false
    
    // MARK: - LifeCycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        addSubview(scrollView)
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func drawRect(rect: CGRect) {
        if calendarScrollDirection == .Horizontal {
            scrollView.contentOffset.x = frame.width
        } else {
            scrollView.contentOffset.y = frame.height
        }
    }
    
    func initialLoad(date: NSDate, autoSelect: Bool) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        threeMonths = [YFMonthView]()
        aDateOfCurrentMonth = date
        loadMonths()
        setConstrains()
        presentedMonthView = threeMonths[1]
        currentDayView = presentedMonthView!.findTheOwnerWithDate(date)
        
        if autoSelect {
            presentedMonthView?.tapActionOnADay(currentDayView!, completion: nil)
        }
        calendarViewDelegate?.calendarView?(self, didPresentTheMonth: presentedMonthView!)
    }
}

extension YFCalendarView: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if calendarScrollDirection == .Horizontal {
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y = 0
            }
            let x = scrollView.contentOffset.x
            if x > scrollView.bounds.width {
                if !willPrensentFunctionHasBeenCalledFlag {
                    self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[2])
                    willPrensentFunctionHasBeenCalledFlag = true
                }
            } else if x < scrollView.bounds.width {
                if !willPrensentFunctionHasBeenCalledFlag {
                    self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[0])
                    willPrensentFunctionHasBeenCalledFlag = true
                }
            }
            
            if x == 2 * scrollView.bounds.width {
                scrollToNext()
            } else if x == 0 {
                scrollToPrevious()
            }
            
        } else {
            if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
            let y = scrollView.contentOffset.y
            if y > scrollView.bounds.height {
                if !willPrensentFunctionHasBeenCalledFlag {
                    self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[2])
                    willPrensentFunctionHasBeenCalledFlag = true
                }
            } else if y < scrollView.bounds.height {
                if !willPrensentFunctionHasBeenCalledFlag {
                    self.calendarViewDelegate?.calendarView?(self, willPresentTheMonth: self.threeMonths[0])
                    willPrensentFunctionHasBeenCalledFlag = true
                }
            }
            
            if y == 2 * scrollView.bounds.height {
                scrollToNext()
            } else if y == 0 {
                scrollToPrevious()
            }
        }
    }
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        willPrensentFunctionHasBeenCalledFlag = false
    }
}

