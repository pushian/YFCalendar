
//
//  OpenViewController
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit
import YFCalendar
class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.whiteColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(10)
        backgroundColor = UIColor.grayColor()
        layer.cornerRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OpenViewController: UIViewController {
    
    var inforLabel: UILabel! = {
        let t = UILabel()
        t.text = "Your Customized Calendar"
        t.font = UIFont.systemFontOfSize(20)
        t.textColor = .blackColor()
        t.textAlignment = .Center
        return t
    }()
    var inforLabelTwo: UILabel! = {
        let t = UILabel()
        t.text = "More features and settings are available through the delegate functions. Please check the ReadMe file regarding the details."
        t.font = UIFont.systemFontOfSize(12)
        t.textColor = .blackColor()
        t.textAlignment = .Center
        t.numberOfLines = 0
        return t
    }()
    var monthLabel: UILabel! = {
        let t = UILabel()
        t.font = UIFont.systemFontOfSize(15)
        t.textColor = .blackColor()
        t.textAlignment = .Center
        return t
    }()
    var buttonOne: UIButton! = {
        let t = UIButton()
        t.setImage(UIImage(named: "arrow"), forState: .Normal)
        return t
    }()
    
    var buttonTwo: UIButton! = {
        let t = UIButton()
        t.setImage(UIImage(named: "arrow"), forState: .Normal)
        t.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        return t
    }()
    var calendarView: YFCalendarView! = {
        let t = YFCalendarView()
        t.layer.cornerRadius = 5
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.darkGrayColor().CGColor
        t.backgroundColor = UIColor.orangeColor()
        return t
    }()
    
    
    var buttonEight: UIButton! = {
        let t = UIButton()
        t.setTitle("Today", forState: .Normal)
        t.titleLabel?.font = UIFont.systemFontOfSize(15)
        t.setTitleColor(.blackColor(), forState: .Normal)
        return t
    }()
    
    var dayInputView: UITextField! = {
        let t = UITextField()
        t.backgroundColor = .whiteColor()
        t.placeholder = "yyyy-mm-dd"
        t.leftView = UIView(frame: CGRectMake(0, 0, 10, 1))
        t.leftViewMode = .Always
        t.layer.borderColor = UIColor.lightGrayColor().CGColor
        t.layer.borderWidth = 1
        t.font = UIFont.systemFontOfSize(10)
        return t
    }()
    
    var buttonThree: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Tap  ", forState: .Normal)
        return t
    }()
    var buttonFour: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Select  ", forState: .Normal)
        return t
    }()
    var buttonFive: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Deselect  ", forState: .Normal)
        return t
    }()
    var buttonSix: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Single Dot  ", forState: .Normal)
        return t
    }()
    
    var buttonNine: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Double Dots  ", forState: .Normal)
        return t
    }()
    
    var buttonTen: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Add One More  ", forState: .Normal)
        return t
    }()
    
    var buttonSeven: BaseButton! = {
        let t = BaseButton()
        t.setTitle("  Clear Dots  ", forState: .Normal)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(monthLabel)
        view.addSubview(inforLabel)
        view.addSubview(calendarView)
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(dayInputView)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
        view.addSubview(buttonFive)
        view.addSubview(buttonSix)
        view.addSubview(buttonSeven)
        view.addSubview(buttonEight)
        view.addSubview(buttonNine)
        view.addSubview(buttonTen)
        view.addSubview(inforLabelTwo)
        setConstraints()
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
        buttonTen.addTarget(self, action: #selector(addOneMoreToADay), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension OpenViewController: YFCalendarViewDelegate {
    func calendarViewAutoSelectToday(calenderView: YFCalendarView) -> Bool {
        return true
    }
    func calendarViewShowDateOutsideOfTheCurrentMonth(calenderView: YFCalendarView) -> Bool {
        return false
    }
    func calendarView(calenderView: YFCalendarView, autoSelectTheFirstDateOfTheNextMonth mode: SelectionMode) -> Bool {
        return true
    }
    func calendarViewSetDateSelectionMode(calenderView: YFCalendarView) -> SelectionMode {
        return .Single
    }
    func calendarViewSetScrollDirection(calenderView: YFCalendarView) -> CalendarScrollDirection {
        return .Horizontal
    }
    func calendarViewSetFontForDateContent(calenderView: YFCalendarView, dateType: DateType, dateState: DateState) -> UIFont? {
        return UIFont.systemFontOfSize(15)
    }
    func calendarView(calenderView: YFCalendarView, didSelectADay selectedDay: YFDayView) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        debugPrint("\(format.stringFromDate(selectedDay.date!)) has been selected.")
    }
    func calendarView(calenderView: YFCalendarView, didPresentTheMonth currentMonth: YFMonthView) {
        let monthArray = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        monthLabel.text = monthArray[currentMonth.currentMonth! - 1]
    }
    
    func calendarViewSetDotMarkRadius(calenderView: YFCalendarView) -> CGFloat {
        return 1
    }
    func calendarViewSetDistanceBetweenDots(calenderView: YFCalendarView) -> CGFloat {
        return 6
    }
    func calendarView(calenderView: YFCalendarView, customizeColorForTheDay theDay: YFDayView, dateState: DateState) -> UIColor? {
        if (theDay.dayName == .Saturday || theDay.dayName == .Sunday) && !theDay.isToday {
            if dateState == .Noselected {
                return UIColor.lightGrayColor()
            } else {
                return UIColor.whiteColor()
            }
        }
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeSelectionCircleBorderColorForTheDay theDay: YFDayView) -> UIColor? {
        if (theDay.dayName == .Saturday || theDay.dayName == .Sunday) && !theDay.isToday {
            return UIColor.lightGrayColor()
        }
        return nil
    }
    func calendarView(calenderView: YFCalendarView, customizeSelectionCircleFillColorForTheDay theDay: YFDayView) -> UIColor? {
        if (theDay.dayName == .Saturday || theDay.dayName == .Sunday) && !theDay.isToday {
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
}

extension OpenViewController {
    func showPrevious() {
        calendarView.presentPreviousMonth()
    }
    
    func showNext() {
        calendarView.presentNextMonth()
    }
    
    func tapADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.sendTapToADate(date)
        }
    }
    func selectADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.selectADate(date)
        }
    }
    func deselectADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.deselectADate(date)
        }
    }
    func singleDotADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.updateDotsToDate(date, dotColorArrays: [UIColor.blueColor()])
        }
    }
    func doubleDotADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.updateDotsToDate(date, dotColorArrays: [UIColor.blueColor(), UIColor.greenColor()])
        }
    }
    func addOneMoreToADay() {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dayStr = dayInputView.text
        if let date = format.dateFromString(dayStr!) {
            calendarView.addDotsToDate(date, dotColorArrays: [UIColor.blueColor()])
        }
    }
    func unDotADay() {
        let format = NSDateFormatter()
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

extension OpenViewController {
    func setConstraints() {
        inforLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: inforLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: inforLabel, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: inforLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: inforLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50))
        
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonOne, attribute: .CenterY, relatedBy: .Equal, toItem: monthLabel, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonOne, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonOne, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20))

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .Leading, relatedBy: .Equal, toItem: buttonOne, attribute: .Trailing, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .Top, relatedBy: .Equal, toItem: inforLabel, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: monthLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonTwo, attribute: .CenterY, relatedBy: .Equal, toItem: monthLabel, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonTwo, attribute: .Leading, relatedBy: .Equal, toItem: monthLabel, attribute: .Trailing, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonTwo, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20))

        buttonEight.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonEight, attribute: .CenterY, relatedBy: .Equal, toItem: monthLabel, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonEight, attribute: .Trailing, relatedBy: .Equal, toItem: calendarView, attribute: .Trailing, multiplier: 1, constant: -10))
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: calendarView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: calendarView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: calendarView, attribute: .Top, relatedBy: .Equal, toItem: monthLabel, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: calendarView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 250))
        
        dayInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: dayInputView, attribute: .Top, relatedBy: .Equal, toItem: calendarView, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: dayInputView, attribute: .Leading, relatedBy: .Equal, toItem: buttonOne, attribute: .Leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: dayInputView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: dayInputView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        
        buttonThree.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonThree, attribute: .CenterY, relatedBy: .Equal, toItem: dayInputView, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonThree, attribute: .Leading, relatedBy: .Equal, toItem: dayInputView, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonThree, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        buttonFour.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonFour, attribute: .CenterY, relatedBy: .Equal, toItem: dayInputView, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonFour, attribute: .Leading, relatedBy: .Equal, toItem: buttonThree, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonFour, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        buttonFive.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonFive, attribute: .CenterY, relatedBy: .Equal, toItem: dayInputView, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonFive, attribute: .Leading, relatedBy: .Equal, toItem: buttonFour, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonFive, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        
        buttonSix.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonSix, attribute: .Top, relatedBy: .Equal, toItem: buttonFive, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonSix, attribute: .Leading, relatedBy: .Equal, toItem: calendarView, attribute: .Leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: buttonSix, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        buttonNine.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonNine, attribute: .Top, relatedBy: .Equal, toItem: buttonFive, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonNine, attribute: .Leading, relatedBy: .Equal, toItem: buttonSix, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonNine, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        
        buttonTen.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonTen, attribute: .Top, relatedBy: .Equal, toItem: buttonFive, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonTen, attribute: .Leading, relatedBy: .Equal, toItem: buttonNine, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonTen, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))

        
        buttonSeven.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: buttonSeven, attribute: .Top, relatedBy: .Equal, toItem: buttonFive, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: buttonSeven, attribute: .Leading, relatedBy: .Equal, toItem: buttonTen, attribute: .Trailing, multiplier: 1, constant: 5))
        view.addConstraint(NSLayoutConstraint(item: buttonSeven, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        
        inforLabelTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: inforLabelTwo, attribute: .Top, relatedBy: .Equal, toItem: buttonSeven, attribute: .Bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: inforLabelTwo, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: inforLabelTwo, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: inforLabelTwo, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -10))

    }
}



