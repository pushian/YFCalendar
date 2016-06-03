//
//  CalendarView.swift
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFCalendarView: YFCalendarBaseView {
    
    //MARK: - Functions Open For User
    public func selectToday() {
        selectADate(NSDate())
    }
    //TODO: Auto check whether the dot number is more than 2
    public func addADotToDate(date: NSDate, dotColor: UIColor) {
        for index in 0..<3 {
            if let day = threeMonths[index].findTheOwnerWithDate(date) {
                day.addADot(dotColor)
            }
        }
        var dotedDate = DotedDate()
        dotedDate.date = date.YFStandardFormatDate()
        
        for index in (0..<dotedDates.count) {
            if dotedDates[index].equalsTo(dotedDate) {
                dotedDates[index].dotColors!.append(dotColor)
                return
            }
        }
        dotedDate.dotColors = [dotColor]
        dotedDates.append(dotedDate)
    }
    
    public func updateDotToDate(date: NSDate, dotColorArrays: [UIColor]) {
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
    
    public func removeDotFromDate(date: NSDate) {
        updateDotToDate(date, dotColorArrays: [UIColor]())
    }
    
    public func clearAllSelection() {
        for each in selectedDayViews {
            each.isSelected = false
        }
        selectedDayViews.removeAll()
        selectedDates.removeAll()
    }
    
    // TODO: - Think again about how to write these three functions
    public func sendTapToADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
        let components = calendar.components(unit, fromDate: date)
        if components == presentedMonthView?.components {
            let dayView = presentedMonthView?.findTheOwnerWithDate(date)
            presentedMonthView?.tapActionOnADay(dayView!)
        } else {
            if selectedDates.contains(date.YFStandardFormatDate()) {
                selectedDates.removeAtIndex(selectedDates.indexOf(date.YFStandardFormatDate())!)
                initialLoad(date, autoSelect: false)
            } else {
                initialLoad(date, autoSelect: true)
            }
        }
    }
    
    public func selectADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
        let components = calendar.components(unit, fromDate: date)
        switch dateSelectionMode {
        case .Single:
            if components == presentedMonthView?.components {
                let dayView = presentedMonthView?.findTheOwnerWithDate(date)
                presentedMonthView?.tapActionOnADay(dayView!)
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
                    presentedMonthView?.tapActionOnADay(dayView!)
                } else {
                    initialLoad(date, autoSelect: true)
                }
            }
        }
    }
    
    public func deselectADate(date: NSDate) {
        let unit = yearUnit.union(monthUnit)
        let components = calendar.components(unit, fromDate: date)
        switch dateSelectionMode {
        case .Single:
            if selectedDates.contains(date.YFStandardFormatDate()) {
                clearAllSelection()
            }
        case .Multiple:
            if selectedDates.contains(date.YFStandardFormatDate()) {
//                switch components {
//                case (presentedMonthView?.components)!:
//                    let day = presentedMonthView?.findTheOwnerWithDate(date)
//                    day?.isSelected = false
//                    selectedDayViews.removeAtIndex(selectedDayViews.indexOf(day!)!)
//                case threeMonths[0].components!:
//                    let day = threeMonths[0].findTheOwnerWithDate(date)
//                    day?.isSelected = false
//                    selectedDayViews.removeAtIndex(selectedDayViews.indexOf(day!)!)
//                case threeMonths[2].components!:
//                    let day = threeMonths[2].findTheOwnerWithDate(date)
//                    day?.isSelected = false
//                    selectedDayViews.removeAtIndex(selectedDayViews.indexOf(day!)!)
//                default:
//                    break
//                }
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
    
    public func presentPreviousMonth(withTarget withTarget: Bool) {
        if pageLoadingEnabled {
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]
            
            updateFrame(toHeight: CGFloat(threeMonths[0].numberOfWeeks()) * appearance!.weekHeight, withAnimation: true)
            UIView.animateWithDuration(0.5, delay: 0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        if self.calendarScrollDirection == .Horizontal {
                                            current.frame.origin.x += self.scrollViewWidth
                                            previous.frame.origin.x += self.scrollViewWidth
                                        } else {
                                            current.frame.origin.y += self.scrollViewHeight
                                            previous.frame.origin.y += self.scrollViewHeight
                                        }
            }) { _ in
                next.removeFromSuperview()
                self.clearSelectedDayViews(ofMonthView: next)
                self.threeMonths[2] = self.threeMonths[1]
                self.threeMonths[1] = self.threeMonths[0]
                self.presentedMonthView = self.threeMonths[1]
                if !withTarget && self.dateSelectionMode == .Single && self.autoSelectTheDayForMonthSwitchInTheSingleMode {
                    if self.presentedMonthView?.components?.year == NSDate().YFComponentsYear() && self.presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                        self.selectADate(NSDate())
                    } else {
                        self.selectADate(self.firstDateOfPreviouMonth!)
                    }
                }
                
                var monthFrame = CGRect()
                if self.calendarScrollDirection == .Horizontal {
                    monthFrame = CGRectMake(CGFloat(0) * self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight)
                } else {
                    monthFrame = CGRectMake(0, CGFloat(0) * self.scrollViewHeight, self.scrollViewWidth, self.scrollViewHeight)
                }
                let newMonth = YFMonthView(calendarView: self, frame: monthFrame, monthIndex: 0)
                self.aDateOfCurrentMonth = self.firstDateOfPreviouMonth
                newMonth.aDayInTheMonth = self.firstDateOfPreviouMonth
                self.threeMonths[0] = newMonth
                self.scrollView.addSubview(newMonth)
                self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
                self.dotDotedDayViews(inMonthView: newMonth)
                self.calendarViewDelegate?.didEndPrensentingTheMonth?()
                self.pageLoadingEnabled = true
            }
        }
    }
    
    public func presentNextMonth(withTarget withTarget: Bool) {
        if pageLoadingEnabled {
            pageLoadingEnabled = false
            let previous = threeMonths[0]
            let current = threeMonths[1]
            let next = threeMonths[2]

            updateFrame(toHeight: CGFloat(threeMonths[2].numberOfWeeks()) * appearance!.weekHeight, withAnimation: true)
            UIView.animateWithDuration(0.5, delay: 0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        if self.calendarScrollDirection == .Horizontal {
                                            current.frame.origin.x -= self.scrollViewWidth
                                            next.frame.origin.x -= self.scrollViewWidth
                                        } else {
                                            current.frame.origin.y -= self.scrollViewHeight
                                            next.frame.origin.y -= self.scrollViewHeight
                                        }
            }) { _ in
                previous.removeFromSuperview()
                self.clearSelectedDayViews(ofMonthView: previous)
                self.threeMonths[0] = self.threeMonths[1]
                self.threeMonths[1] = self.threeMonths[2]
                self.presentedMonthView = self.threeMonths[1]
                if !withTarget && self.dateSelectionMode == .Single && self.autoSelectTheDayForMonthSwitchInTheSingleMode {
                    if self.presentedMonthView?.components?.year == NSDate().YFComponentsYear() && self.presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                        self.selectADate(NSDate())
                    } else {
                        self.selectADate(self.firstDateOfNextMonth!)
                    }
                }
                
                var monthFrame = CGRect()
                if self.calendarScrollDirection == .Horizontal {
                    monthFrame = CGRectMake(CGFloat(2) * self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight)
                } else {
                    monthFrame = CGRectMake(0, CGFloat(2) * self.scrollViewHeight, self.scrollViewWidth, self.scrollViewHeight)
                }

                let newMonth = YFMonthView(calendarView: self, frame: monthFrame, monthIndex: 2)
                self.aDateOfCurrentMonth = self.firstDateOfNextMonth
                newMonth.aDayInTheMonth = self.firstDateOfNextMonth
                self.threeMonths[2] = newMonth
                self.scrollView.addSubview(newMonth)
                self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
                self.dotDotedDayViews(inMonthView: newMonth)
                self.calendarViewDelegate?.didEndPrensentingTheMonth?()
                self.pageLoadingEnabled = true
            }
        }
    }
    
    //MARK: - Public Functions
    //MARK: - Private Functions
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
            scrollView.scrollRectToVisible(rectOf(threeMonths[1]), animated: false)
            if self.dateSelectionMode == .Single && autoSelectTheDayForMonthSwitchInTheSingleMode {
                if presentedMonthView?.components?.year == NSDate().YFComponentsYear() && presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                    self.selectADate(NSDate())
                } else {
                    self.selectADate(self.firstDateOfNextMonth!)
                }
            }
            var monthFrame = CGRect()
            if calendarScrollDirection == .Horizontal {
                monthFrame = CGRectMake(CGFloat(2) * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)
            } else {
                monthFrame = CGRectMake(0, CGFloat(2) * scrollViewHeight, scrollViewWidth, scrollViewHeight)
            }
            let newMonth = YFMonthView(calendarView: self, frame: monthFrame, monthIndex: 2)
            aDateOfCurrentMonth = firstDateOfNextMonth
            newMonth.aDayInTheMonth = firstDateOfNextMonth
            threeMonths[2] = newMonth
            scrollView.addSubview(newMonth)
            self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
            self.dotDotedDayViews(inMonthView: newMonth)
            calendarViewDelegate?.didEndPrensentingTheMonth?()
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
            scrollView.scrollRectToVisible(rectOf(threeMonths[1]), animated: false)
            if self.dateSelectionMode == .Single && autoSelectTheDayForMonthSwitchInTheSingleMode {
                if presentedMonthView?.components?.year == NSDate().YFComponentsYear() && presentedMonthView?.components?.month == NSDate().YFComponentsMonth() {
                    self.selectADate(NSDate())
                } else {
                    self.selectADate(self.firstDateOfPreviouMonth!)
                }
            }
            var monthFrame = CGRect()
            if calendarScrollDirection == .Horizontal {
                monthFrame = CGRectMake(CGFloat(0) * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)
            } else {
                monthFrame = CGRectMake(0, CGFloat(0) * scrollViewHeight, scrollViewWidth, scrollViewHeight)
            }
            let newMonth = YFMonthView(calendarView: self, frame: monthFrame, monthIndex: 0)
            aDateOfCurrentMonth = firstDateOfPreviouMonth
            newMonth.aDayInTheMonth = firstDateOfPreviouMonth
            threeMonths[0] = newMonth
            scrollView.addSubview(newMonth)
            self.selectPreviouslySelectedDayViews(inMonthView: newMonth)
            self.dotDotedDayViews(inMonthView: newMonth)
            calendarViewDelegate?.didEndPrensentingTheMonth?()
            pageLoadingEnabled = true
        }
    }
    
    private func replaceMonthView(oldMonth: YFMonthView, with newMonth: YFMonthView) {
        let frameOriginOfOld = oldMonth.frame.origin
        newMonth.frame.origin = frameOriginOfOld
    }
    
    private func updateFrame(toHeight height: CGFloat, withAnimation: Bool) {
//        if height != scrollView.frame.height {
        if height != frame.height {
            for each in superview!.constraints {
                if let _ = each.firstItem as? YFCalendarView {
                    if each.firstAttribute == .Height {
                        each.constant = height
                        break
                    }
                }
            }
            var superStack = [UIView]()
            var currentView: UIView = self
            while let currentSuperview = currentView.superview where !(currentSuperview is UIWindow) {
                superStack += [currentSuperview]
                currentView = currentSuperview
            }
            
            if withAnimation {
                UIView.animateWithDuration(0.5, animations: {
                    self.frame.size.height = height
                    for view in superStack {
                        view.layoutIfNeeded()
                    }
                })
            } else {
                self.frame.size.height = height
                for view in superStack {
                    view.layoutIfNeeded()
                }
            }
            
        }
    }
    private func loadMonths() {
        insertMonthView(0, date: firstDateOfPreviouMonth!)
        insertMonthView(1, date: aDateOfCurrentMonth!)
        insertMonthView(2, date: firstDateOfNextMonth!)
    }
    
    private func insertMonthView(index: Int, date: NSDate) {
        
        var monthFrame = CGRect()
        if calendarScrollDirection == .Horizontal {
            monthFrame = CGRectMake(CGFloat(index) * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)
        } else {
            monthFrame = CGRectMake(0, CGFloat(index) * scrollViewHeight, scrollViewWidth, scrollViewHeight)
        }
        
        let monthView = YFMonthView(calendarView: self, frame: monthFrame, monthIndex: index)
        monthView.aDayInTheMonth = date
        threeMonths.append(monthView)
        scrollView.addSubview(monthView)
        selectPreviouslySelectedDayViews(inMonthView: monthView)
        self.dotDotedDayViews(inMonthView: monthView)
    }
    
    private func setConstrains() {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .Top,
            relatedBy: .Equal, toItem: superview, attribute: .Top,
            multiplier: 1, constant: frame.origin.y))
        superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .Leading,
            relatedBy: .Equal, toItem: superview, attribute: .Leading,
            multiplier: 1, constant: frame.origin.x))
        superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .Width,
            relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute,
            multiplier: 1, constant: frame.width))
        superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .Height,
            relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute,
            multiplier: 1, constant: frame.height))
    }
    
    private func rectOf(monthView: YFMonthView) -> CGRect {
        let rect = monthView.frame
        return rect
    }
    private func checkTheSameDay(monthIndex: Int, day: YFDayView) -> YFDayView? {
        if monthIndex == 0 {
            if day.weekView.weekIndex == threeMonths[monthIndex].numberOfWeeks() {
                return threeMonths[monthIndex + 1].findTheOwnerWithDate(day.date!)
            }
        }
        if monthIndex == 1 {
            if day.weekView.weekIndex == threeMonths[monthIndex].numberOfWeeks() {
                return threeMonths[monthIndex + 1].findTheOwnerWithDate(day.date!)
            }
            if day.weekView.weekIndex == 1 {
                return threeMonths[monthIndex - 1].findTheOwnerWithDate(day.date!)
            }
        }
        if monthIndex == 2 {
            if day.weekView.weekIndex == 1 {
                return threeMonths[monthIndex - 1].findTheOwnerWithDate(day.date!)
            }
        }
        return nil
    }
    //MARK: - Variables Open For User
    
    weak public var calendarViewDelegate: YFCalendarViewDelegate? {
        didSet {
            if appearance  == nil {
                appearance = YFCalendarAppearance()
            }
        }
    }
    weak public var calendarAppearanceDelegate: YFCalendarAppearanceDelegate? {
        didSet {
            if appearance  == nil {
                appearance = YFCalendarAppearance()
            }
            appearance?.delegate = calendarAppearanceDelegate
            if calendarScrollDirection == .Horizontal {
                scrollView.contentSize = CGSize(width: scrollViewWidth * 3, height: scrollViewHeight)
            } else {
                scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight * 3)
            }
            if autoSelectToday {
                initialLoad(NSDate(),autoSelect: true)
            } else {
                initialLoad(NSDate(),autoSelect: false)
            }
        }
    }
    
    public var selectedDayViews = [YFDayView]()
    public var selectedDates = [NSDate]()
    
    public var dotedDates = [DotedDate]()
    public var presentedMonthView: YFMonthView?
    
    //MARK: - Delegate Related Variables
    var calendarScrollDirection: CalendarScrollDirection {
        if let delegate = calendarViewDelegate, let calendarScrollDirection = delegate.calendarScrollDirection?() {
            return calendarScrollDirection
        } else {
            return .Horizontal
        }
    }
    
    var dateSelectionMode: SelectionMode {
        if let delegate = calendarViewDelegate, let dateSelectionMode = delegate.dateSelectionMode?() {
            return dateSelectionMode
        } else {
            return .Single
        }
    }

    var turnOnAnimationOnDay: Bool {
        if let delegate = calendarViewDelegate, let turnOnAnimationOnDay = delegate.turnOnAnimationOnDay?() {
            return turnOnAnimationOnDay
        } else {
            return true
        }
    }
    
    var autoSelectTheDayForMonthSwitchInTheSingleMode: Bool {
        if let delegate = calendarViewDelegate, let autoSelectTheDayForMonthSwitchInTheSingleMode = delegate.autoSelectTheDayForMonthSwitchInTheSingleMode?() {
            return autoSelectTheDayForMonthSwitchInTheSingleMode
        } else {
            return true
        }
    }
    
    var autoScrollToTheNewMonth: Bool {
        if let delegate = calendarViewDelegate, let autoScrollToTheNewMonth = delegate.autoScrollToTheNewMonth?() {
            return autoScrollToTheNewMonth
        } else {
            return true
        }
    }
    
    var autoSelectToday: Bool {
        if let delegate = calendarViewDelegate, let autoSelectToday = delegate.autoSelectToday?() {
            return autoSelectToday
        } else {
            return true
        }
    }
    //MARK: - Other Public Variables
    var appearance: YFCalendarAppearance? {
        didSet {
            if let appearance = appearance {
                appearance.weekHeight = frame.height / CGFloat(numberOfWeeks)
                appearance.dayWidth = frame.width / 7.0
            }
        }
    }
    var threeMonths = [YFMonthView]()
    //MARK: - Private Variables
    private var scrollViewWidth: CGFloat = 0
    private var scrollViewHeight: CGFloat = 0
    private var firstLoadIsDone = false
    private var numberOfWeeks = 6
    
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
            var components = calendar.components(unit, fromDate: aDateOfCurrentMonth!)
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
            var components = calendar.components(unit, fromDate: aDateOfCurrentMonth!)
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

    // MARK: - LifeCycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        scrollViewWidth = frame.width
        scrollViewHeight = frame.height

        scrollView.frame = CGRectMake(0, 0, scrollViewWidth, scrollViewHeight)
        scrollView.delegate = self
        addSubview(scrollView)
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialLoad(date: NSDate, autoSelect: Bool) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        threeMonths = [YFMonthView]()
        aDateOfCurrentMonth = date
        
        loadMonths()

        scrollView.scrollRectToVisible(rectOf(threeMonths[1]), animated: false)
        presentedMonthView = threeMonths[1]
        currentDayView = presentedMonthView!.findTheOwnerWithDate(date)
        if !firstLoadIsDone {
            setConstrains()
            firstLoadIsDone = true
        }
        var currentView: UIView = self
        while let currentSuperview = currentView.superview where !(currentSuperview is UIWindow) {
            currentView = currentSuperview
        }
        currentView.layoutIfNeeded()
        //TODO:
        if autoSelect {
            presentedMonthView?.tapActionOnADay(currentDayView!)
        }
        updateFrame(toHeight: CGFloat(threeMonths[1].numberOfWeeks()) * appearance!.weekHeight, withAnimation: true)
        calendarViewDelegate?.didEndPrensentingTheMonth?()
    }
    
}

extension YFCalendarView: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentHeight = CGFloat(threeMonths[1].numberOfWeeks()) * appearance!.weekHeight
        let previousHeight = CGFloat(threeMonths[0].numberOfWeeks()) * appearance!.weekHeight
        let nextHeight = CGFloat(threeMonths[2].numberOfWeeks()) * appearance!.weekHeight

        if calendarScrollDirection == .Horizontal {
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y = 0
            }
            let x = scrollView.contentOffset.x
            if x > scrollViewWidth {
                if nextHeight != currentHeight {
                    updateFrame(toHeight: currentHeight + (nextHeight - currentHeight) * (x - scrollViewWidth) / scrollViewWidth, withAnimation: false)
                }
            } else if x < frame.width {
                if previousHeight != currentHeight {
                    updateFrame(toHeight: currentHeight + (previousHeight - currentHeight) * (scrollViewWidth - x) / scrollViewWidth, withAnimation: false)
                }
            }
            
            if x == 2 * scrollViewWidth {
                scrollToNext()
            } else if x == 0 {
                scrollToPrevious()
            }
            
        } else {
            if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
            let y = scrollView.contentOffset.y
            if y > scrollViewHeight {
                if nextHeight != currentHeight {
                    updateFrame(toHeight: currentHeight + (nextHeight - currentHeight) * (y - scrollViewHeight) / scrollViewHeight, withAnimation: false)
                }
            } else if y < scrollViewHeight {
                if previousHeight != currentHeight {
                    updateFrame(toHeight: currentHeight + (previousHeight - currentHeight) * (scrollViewHeight - y) / scrollViewHeight, withAnimation: false)
                }
            }
            
            if y == 2 * scrollViewHeight {
                scrollToNext()
            } else if y == 0 {
                scrollToPrevious()
            }
            
            
        }
    }

//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        let x = scrollView.contentOffset.x
//        if x > frame.width {
//            scrollToLeft()
//        } else if x < frame.width {
//            scrollToRight()
//        }
//    }
}

