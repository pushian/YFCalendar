
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
        t.setTitle("Dot", forState: .Normal)
        t.backgroundColor = .blackColor()
        t.setTitleColor(.whiteColor(), forState: .Normal)
        return t
    }()
    
    var buttonSeven: UIButton! = {
        let t = UIButton(frame: CGRectMake(10, 290, 100, 30))
        t.setTitle("Undot", forState: .Normal)
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
        
        setConstraints()
        calendarView.calendarViewDelegate = self
        calendarView.calendarAppearanceDelegate = self
        buttonOne.addTarget(self, action: #selector(showPrevious), forControlEvents: .TouchUpInside)
        buttonTwo.addTarget(self, action: #selector(showNext), forControlEvents: .TouchUpInside)
        buttonThree.addTarget(self, action: #selector(tapADay), forControlEvents: .TouchUpInside)
        buttonFour.addTarget(self, action: #selector(selectADay), forControlEvents: .TouchUpInside)
        buttonFive.addTarget(self, action: #selector(deselectADay), forControlEvents: .TouchUpInside)
        buttonSix.addTarget(self, action: #selector(dotADay), forControlEvents: .TouchUpInside)
        buttonSeven.addTarget(self, action: #selector(unDotADay), forControlEvents: .TouchUpInside)
        buttonEight.addTarget(self, action: #selector(selectToday), forControlEvents: .TouchUpInside)
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
        calendarView.presentPreviousMonth(withTarget: false)
    }
    
    func showNext() {
        calendarView.presentNextMonth(withTarget: false)
    }
    
    func tapADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        let date = format.dateFromString(dayStr!)
        calendarView.sendTapToADate(date!)
    }
    func selectADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        let date = format.dateFromString(dayStr!)
        calendarView.selectADate(date!)
    }
    func deselectADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        let date = format.dateFromString(dayStr!)
        calendarView.deselectADate(date!)
    }
    func dotADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        let date = format.dateFromString(dayStr!)
        calendarView.addDotToDate(date!)
    }
    func unDotADay() {
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        let date = format.dateFromString(dayStr!)
        calendarView.removeDotFromDate(date!)
    }
    func selectToday() {
        calendarView.selectToday()
    }
}

extension OpenViewController: YFCalendarViewDelegate {
    func dateSelectionMode() -> SelectionMode {
        return .Multiple
    }
    
    func turnOnAnimationOnDay() -> Bool {
        return true
    }
    
    func calendarScrollDirection() -> CalendarScrollDirection {
        return .Vertical
    }
    
    func didEndPrensentingTheMonth() {
    }
    
    func didEndSelectingADay(selectedDay: YFDayView) {
    }
}

extension OpenViewController: YFCalendarAppearanceDelegate {
    
    func dotMarkRadius() -> CGFloat {
        return 2
    }
    
    func dotMarkOffsetFromDateLabel() -> CGFloat {
        return 2
    }
    
    func dotMarkUnselectedColor() -> UIColor {
        return .orangeColor()
    }
    
    func selectionCircleRadius() -> CGFloat {
        return 17
    }
    
    func autoSelectTheDayForMonthSwitchInTheSingleMode() -> Bool {
        return false
    }
    
    func showDateOutsideOfTheCurrentMonth() -> Bool {
        return true
    }
    
}

