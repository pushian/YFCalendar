//
//  DayView.swift
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFDayView: YFCalendarBaseView {
    //MARK: - Weak Reference
    unowned let weekView: YFWeekView
    unowned let monthView: YFMonthView
    unowned let calendarView: YFCalendarView
    unowned let appearance: YFCalendarAppearance
    
    //MARK: - Functions Open For User
    //MARK: - Public Functions
    func addDots(dotColor: [UIColor]) {
        if dotView.colors == nil {
            dotView.colors = dotColor
        } else {
            dotView.colors?.appendContentsOf(dotColor)
        }
        dotView.setNeedsDisplay()
    }
    
    func updateDotView(dotColorArrays: [UIColor]) {
        dotView.colors = dotColorArrays
        dotView.setNeedsDisplay()
    }
    
    func belongsToDate(date: NSDate) -> Bool {
        let unit = yearUnit.union(monthUnit).union(dayUnit)
        let componentsOne = calendar.components(unit, fromDate: self.date!)
        let componentsTwo = calendar.components(unit, fromDate: date)
        if componentsOne == componentsTwo {
            return true
        } else {
            return false
        }
    }
    //MARK: - Private Functions
    private func checkWhetherIsInside() {
        if let theDate = monthView.daysInsideTheMonth[weekView.weekIndex]![dayIndex] {
            isInside = true
            date = theDate
        } else {
            if let theDate = monthView.daysOutsideTheMonth[weekView.weekIndex]![dayIndex] {
                isInside = false
                date = theDate
            }
        }
        
    }
    
    private func updateDisplay() {
        dayLabel.font = appearance.fontOfDateLabel
        var textColor: UIColor?
        
        if date == NSDate().YFStandardFormatDate() {
            textColor = appearance.colorOfDateToday
        } else {
            if isInside! {
                if !calendarView.showDateOutside {
                    if components?.weekday == 1 || components?.weekday == 7 {
                        textColor = appearance.colorOfWeekend
                    } else {
                        textColor = appearance.colorOfWeekday
                    }
                } else {
                    textColor = appearance.colorOfDateInsideMonth
                }
            } else {
                textColor = appearance.colorOfDateOutsideMonth
                if !calendarView.showDateOutside {
                    hidden = true
                }
            }
        }
        if let color = appearance.delegate?.calendarView?(calendarView, customizeColorForTheDay: self) {
            textColor = color
        }
        dayLabel.textColor = textColor
    }
    
    private func setConstrains() {
        let centerXConstraint = NSLayoutConstraint(item: dayLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        addConstraint(centerXConstraint)
        
        let centerYConstraint = NSLayoutConstraint(item: dayLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        addConstraint(centerYConstraint)
    }
    
    
    private func beSelected (animation: Bool) {
        dayLabel.textColor = UIColor.whiteColor()
        dotView.shape = .SelectedDotMarks
        dotView.setNeedsDisplay()
        if animation {
            selectWithBubbleEffect()
        } else {
            selectionView?.alpha = 1
            if self.date == NSDate().YFStandardFormatDate() {
                selectionView.shape = .CircleWithFill
                selectionView.setNeedsDisplay()
            }
        }
    }
    
    private func beDeselected (animation: Bool) {
        dotView.shape = .UnselectedDotMarks
        dotView.setNeedsDisplay()
        if animation {
            deselectionWithBubbleEffect()
        } else {
            self.updateDisplay()
            if self.date == NSDate().YFStandardFormatDate() {
                selectionView.shape = .CircleWithOutFill
                selectionView.setNeedsDisplay()
            } else {
                self.selectionView?.alpha = 0
            }
        }
    }
    //MARK: - Variables Open For User
    public var date: NSDate? {
        didSet {
            if let date = date {
                let unit = yearUnit.union(monthUnit).union(dayUnit).union(weekUnit).union(weekdayUnit)
                components = calendar.components(unit, fromDate: date)
                dayLabelText = String(components!.day)
            }
        }
    }
    //MARK: - Public Variables
    var components: NSDateComponents?
    var dayIndex: Int!
    var isSelected: Bool? = false {
        didSet {
            if let isSelected = isSelected {
                if isSelected {
                    beSelected(calendarView.turnOnAnimationOnDay)
                } else {
                    beDeselected(calendarView.turnOnAnimationOnDay)
                }
            }
        }
    }
    var isInside: Bool?
    
    var dayLabel: UILabel! = {
        let t = UILabel()
        t.backgroundColor = UIColor.clearColor()
        t.textAlignment = .Center
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    var dotView: YFCustomizedShape!
    var lineView: YFCustomizedShape!
    
    //MARK: - Private Variables
    private var dayLabelText: String? {
        didSet {
            if let dayLabelText = dayLabelText {
                dayLabel.text = dayLabelText
                dayLabel.sizeToFit()
                if appearance.selectionCircleRadius == 0 {
                    appearance.selectionCircleRadius = (dayLabel.frame.height / 2) * 1.5
                }
            }
        }
    }
    
    private var selectionView: YFCustomizedShape!
    
    //MARK: - Life Cycle
    init(weekView: YFWeekView, frame: CGRect, dayIndex: Int) {
        self.weekView = weekView
        monthView = self.weekView.monthView
        calendarView = monthView.calendarView
        appearance = calendarView.appearance!
        self.dayIndex = dayIndex
        super.init(frame: frame)
        self.backgroundColor = .whiteColor()
        checkWhetherIsInside()
        let selectionViewFrame = CGRectMake(0, 0, frame.width, frame.height)
        selectionView = YFCustomizedShape(dayView: self, shape: .CircleWithFill, frame: selectionViewFrame)
        let dotFrame = CGRectMake(0, 0, frame.width, frame.height)
        dotView = YFCustomizedShape(dayView: self, shape: .UnselectedDotMarks, frame: dotFrame)
        dotView.colors = appearance.delegate?.calendarView?(calendarView, initializeDotsForTheDay: self)
        dotView.setNeedsDisplay()
        lineView = YFCustomizedShape(dayView: self, shape: .TopLine, frame: dotFrame)
        if date == NSDate().YFStandardFormatDate() {
            selectionView.shape = .CircleWithOutFill
            selectionView.setNeedsDisplay()
        } else {
            selectionView.alpha = 0
        }
        if appearance.showTopLine! {
            lineView.alpha = 1
        } else {
            lineView.alpha = 0
        }
        addSubview(selectionView!)
        addSubview(dotView)
        addSubview(lineView)
        addSubview(dayLabel)
        setConstrains()
        updateDisplay()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Animation
extension YFDayView {
    private func selectWithBubbleEffect() {
        self.layer.removeAllAnimations()
        selectionView?.alpha = 1
        selectionView?.transform = CGAffineTransformMakeScale(0.5, 0.5)
        dayLabel?.transform = CGAffineTransformMakeScale(0.5, 0.5)
        if self.date == NSDate().YFStandardFormatDate() {
            selectionView.shape = .CircleWithFill
            selectionView.setNeedsDisplay()
        }
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3,
                                   initialSpringVelocity: 0.1,
                                   options: UIViewAnimationOptions.BeginFromCurrentState,
                                   animations: {
                                    self.selectionView?.transform = CGAffineTransformMakeScale(1, 1)
                                    self.dayLabel?.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)

    }

    private func deselectionWithBubbleEffect(){
        UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.8,
                                   options: UIViewAnimationOptions.CurveEaseOut, animations: {
                                    self.selectionView!.transform = CGAffineTransformMakeScale(1.1, 1.1)
                                    self.dayLabel!.transform = CGAffineTransformMakeScale(1.1, 1.1)
        }) { _ in
            self.updateDisplay()
            UIView.animateWithDuration(0.2, delay: 0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: {
                                        if self.date == NSDate().YFStandardFormatDate() {
                                            self.selectionView.transform = CGAffineTransformMakeScale(1, 1)
                                            self.selectionView.shape = .CircleWithOutFill
                                            self.selectionView.setNeedsDisplay()
                                        } else {
                                            self.selectionView.transform = CGAffineTransformMakeScale(0.01, 0.01)
                                        }
                                        self.dayLabel!.transform = CGAffineTransformMakeScale(1, 1)

            }) { _ in
                if self.date != NSDate().YFStandardFormatDate() {
                    self.selectionView?.alpha = 0
                }
            }
        }
    }
}
