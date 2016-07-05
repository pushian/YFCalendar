
//
//  OpenViewController
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit
import YFCalendar

class OpenViewController: UIViewController {
    
    var calendarView: YFCalendarView! = {
        let t = YFCalendarView(frame: CGRectMake(0, 20, UIScreen.mainScreen().bounds.width, 300))
        t.backgroundColor = UIColor.orangeColor()
        return t
    }()
    
    var buttonOne: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 10, 100, 30))
        t.setTitle("Previous", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonTwo: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 50, 100, 30))
        t.setTitle("Next", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var dayInputView: UITextField! = {
        let t = UITextField(frame: CGRectMake(10, 90, 100, 30))
        t.backgroundColor = .whiteColor()
        t.placeholder = "yyyy-mm-dd"
        return t
    }()
    
    var buttonThree: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 130, 100, 30))
        t.setTitle("Tap", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    var buttonFour: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 170, 100, 30))
        t.setTitle("Select", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    var buttonFive: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 210, 100, 30))
        t.setTitle("Deselect", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    var buttonSix: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 250, 100, 30))
        t.setTitle("Single Dot", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonNine: UIButton! = {
        let t = UIButton(frame: CGRectMake(120, 250, 100, 30))
        t.setTitle("Double Dots", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonTen: UIButton! = {
        let t = UIButton(frame: CGRectMake(120, 290, 100, 30))
        t.setTitle("Add Dots", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonSeven: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 290, 100, 30))
        t.setTitle("Clear Dots", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonEight: UIButton! = {
        let t = UIButton(frame: CGRectMake(120, 10, 100, 30))
        t.setTitle("Today", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var lowerView: UIView! = {
        let t = UIView(frame: CGRectZero)
        t.backgroundColor = UIColor.blueColor()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(calendarView)
        view.addSubview(lowerView)
        lowerView.addSubview(buttonOne)
        lowerView.addSubview(buttonTwo)
        lowerView.addSubview(dayInputView)
        lowerView.addSubview(buttonThree)
        lowerView.addSubview(buttonFour)
        lowerView.addSubview(buttonFive)
        lowerView.addSubview(buttonSix)
        lowerView.addSubview(buttonSeven)
        lowerView.addSubview(buttonEight)
        lowerView.addSubview(buttonNine)
        lowerView.addSubview(buttonTen)
        
        setConstraints()
        calendarView.calendarAppearanceDelegate = self
        calendarView.calendarViewDelegate = self
        buttonOne.addTarget(self, action: #selector(showPrevious), forControlEvents: .TouchUpInside)
        buttonTwo.addTarget(self, action: #selector(showNext), forControlEvents: .TouchUpInside)
        buttonThree.addTarget(self, action: #selector(tapADay), forControlEvents: .TouchUpInside)
        buttonFour.addTarget(self, action: #selector(selectADay), forControlEvents: .TouchUpInside)
        buttonFive.addTarget(self, action: #selector(deselectADay), forControlEvents: .TouchUpInside)
        buttonSix.addTarget(self, action: #selector(singleDotADay), forControlEvents: .TouchUpInside)
        buttonSeven.addTarget(self, action: #selector(unDotADay), forControlEvents: .TouchUpInside)
        buttonEight.addTarget(self, action: #selector(selectToday), forControlEvents: .TouchUpInside)
        buttonNine.addTarget(self, action: #selector(doubleDotADay), forControlEvents: .TouchUpInside)
        buttonTen.addTarget(self, action: #selector(addDotsToADay), forControlEvents: .TouchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func setConstraints() {
        let topConstrainsTwo = NSLayoutConstraint(item: lowerView, attribute: .Top, relatedBy: .Equal, toItem: calendarView, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(topConstrainsTwo)
        let bottomConstrainsTwo = NSLayoutConstraint(item: lowerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstrainsTwo)
        let leadConstrainsTwo = NSLayoutConstraint(item: lowerView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(leadConstrainsTwo)
        let trailConstrainsTwo = NSLayoutConstraint(item: lowerView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(trailConstrainsTwo)
    }
    
    func showPrevious() {
        calendarView.presentPreviousMonth()
    }
    
    func showNext() {
        calendarView.presentNextMonth()
    }
    
    func tapADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.sendTapToADate(date)
        }
    }
    func selectADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.selectADate(date)
        }
    }
    func deselectADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.deselectADate(date)
        }
    }
    func singleDotADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.updateDotsToDate(date, dotColorArrays: [UIColor.blueColor()])
        }
    }
    func doubleDotADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.updateDotsToDate(date, dotColorArrays: [UIColor.blueColor(), UIColor.greenColor()])
        }
    }
    func addDotsToADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.addDotsToDate(date, dotColorArrays: [UIColor.blueColor(), UIColor.greenColor()])
        }
    }
    func unDotADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.removeDotFromDate(date)
        }
    }
    func selectToday() {
        calendarView.selectToday()
    }
}

extension OpenViewController: YFCalendarViewDelegate {
    func calendarViewAutoSelectToday(calenderView: YFCalendarView) -> Bool {
        return true
    }
    
    func calendarViewShowDateOutsideOfTheCurrentMonth(calenderView: YFCalendarView) -> Bool {
        return false
    }
    
    func calendarViewSetDateSelectionMode(calenderView: YFCalendarView) -> SelectionMode {
        return .Multiple
    }
    func calendarViewSetScrollDirection(calenderView: YFCalendarView) -> CalendarScrollDirection {
        return .Vertical
    }
    func calendarView(calenderView: YFCalendarView, didSelectADay selectedDay: YFDayView) {
    }
    
    func calendarView(calenderView: YFCalendarView, willPresentTheMonth currentMonth: YFMonthView) {
    }
    func calendarView(calenderView: YFCalendarView, didPresentTheMonth currentMonth: YFMonthView) {
    }
    
}

extension OpenViewController: YFCalendarAppearanceDelegate {
    func calendarViewSetDotMarkRadius(calenderView: YFCalendarView) -> CGFloat {
        return 1
    }
    func calendarViewSetDistanceBetweenDots(calenderView: YFCalendarView) -> CGFloat {
        return 6
    }
    
    func calendarView(calenderView: YFCalendarView, disableUserInteractionForTheDay: YFDayView) -> Bool {
        return false
    }
    func calendarView(calenderView: YFCalendarView, initializeDotsForTheDay theDay: YFDayView) -> [UIColor]? {
        
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeColorForTheDay theDay: YFDayView, dateState: DateState) -> UIColor? {
        if theDay.dayName == .Saturday || theDay.dayName == .Sunday {
            if dateState == .Noselected {
                return UIColor.lightGrayColor()
            } else {
                return UIColor.whiteColor()
            }
        }
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeSelectionCircleBorderColorForTheDay theDay: YFDayView) -> UIColor? {
        if theDay.dayName == .Saturday || theDay.dayName == .Sunday {
            return UIColor.lightGrayColor()
        }
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeSelectionCircleFillColorForTheDay theDay: YFDayView) -> UIColor? {
        if theDay.dayName == .Saturday || theDay.dayName == .Sunday {
            return UIColor.lightGrayColor()
        }
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeContentViewForTheDay theDay: YFDayView, dateState: DateState) -> UIView? {
        let unit = NSCalendarUnit.Day.union(NSCalendarUnit.Month)
        let component = NSCalendar.currentCalendar().components(unit, fromDate: theDay.date!)
        if component.day == 1 {
            let view = UIView()
            view.backgroundColor = .clearColor()
            let labelOne = UILabel()
            let labelTwo = UILabel(frame: theDay.bounds)
            let monthArray = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            labelOne.text = monthArray[component.month - 1]
            labelOne.sizeToFit()
            labelOne.frame = CGRectMake(0, 0, theDay.bounds.width, labelOne.frame.height)
            labelOne.font = UIFont.systemFontOfSize(8)
            labelTwo.font = UIFont.systemFontOfSize(15)
            labelTwo.text = String(component.day)
            labelOne.textAlignment = .Center
            labelTwo.textAlignment = .Center
            view.addSubview(labelOne)
            view.addSubview(labelTwo)
            if dateState == .Noselected {
                labelOne.textColor = .orangeColor()
                labelTwo.textColor = .blackColor()
            } else {
                labelOne.textColor = .whiteColor()
                labelTwo.textColor = .whiteColor()
            }
            return view
        }
        return nil
    }
    
    func calendarViewSetFontForDateContent(calenderView: YFCalendarView, dateType: DateType, dateState: DateState) -> UIFont? {
        return UIFont.systemFontOfSize(15)
    }
}



