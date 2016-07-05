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
        if let view = appearance.delegate?.calendarView?(calendarView, customizeContentViewForTheDay: self, dateState: isSelected! ? .Selected : .Noselected) {
            if !isInside! && !calendarView.showDateOutside {
                hidden = true
            } else {
                for each in contentView.subviews {
                    each.removeFromSuperview()
                }
                view.frame = contentView.bounds
                contentView.addSubview(view)
                contentView.hidden = false
                dayLabel.hidden = true
            }
        } else {
            contentView.hidden = true
            dayLabel.hidden = false
            var textColor: UIColor?
            var textFont: UIFont?
            if date == NSDate().YFStandardFormatDate() {
                if isSelected! {
                    textColor = appearance.colorOfDateTodayWhenSelected
                    textFont = appearance.fontOfDateTodayWhenSelected
                } else {
                    textColor = appearance.colorOfDateToday
                    textFont = appearance.fontOfDateToday
                }
            } else {
                if isInside! {
                    if isSelected! {
                        textColor = appearance.colorOfDateInsideMonthWhenSelected
                        textFont = appearance.fontOfDateInsideMonthWhenSelected
                    } else {
                        textColor = appearance.colorOfDateInsideMonth
                        textFont = appearance.fontOfDateInsideMonth
                    }
                } else {
                    if isSelected! {
                        textColor = appearance.colorOfDateOutsideMonthWhenSelected
                        textFont = appearance.fontOfDateOutsideMonthWhenSelected
                    } else {
                        textColor = appearance.colorOfDateOutsideMonth
                        textFont = appearance.fontOfDateOutsideMonth
                    }
                    if !calendarView.showDateOutside {
                        hidden = true
                    }
                }
            }
            if let color = appearance.delegate?.calendarView?(calendarView, customizeColorForTheDay: self, dateState: isSelected! ? .Selected: .Noselected) {
                textColor = color
            }
            if let font = appearance.delegate?.calendarView?(calendarView, customizeFontForTheDay: self, dateState: isSelected! ? .Selected: .Noselected) {
                textFont = font
            }
            dayLabel.textColor = textColor
            dayLabel.font = textFont
        }
    }
    
//    private func setConstrains() {
//        let centerXConstraint = NSLayoutConstraint(item: dayLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
//        addConstraint(centerXConstraint)
//        
//        let centerYConstraint = NSLayoutConstraint(item: dayLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
//        addConstraint(centerYConstraint)
//    }
    
    
    private func beSelected (animation: Bool) {
        updateDisplay()
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
            updateDisplay()
            self.selectionView?.alpha = 0
        }
    }
    //MARK: - Variables Open For User
    private(set) public var date: NSDate? {
        didSet {
            if let date = date {
                let unit = yearUnit.union(monthUnit).union(dayUnit).union(weekUnit).union(weekdayUnit)
                components = calendar.components(unit, fromDate: date)
                dayLabelText = String(components!.day)
            }
        }
    }
    public var dayName: DayName {
        get {
            return DayName(rawValue: dayIndex)!
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
        return t
    }()
    var contentView: UIView! = {
        let t = UIView()
        t.backgroundColor = UIColor.clearColor()
        return t
    }()
    
    var dotView: YFCustomizedShape!
    var lineView: YFCustomizedShape!
    
    //MARK: - Private Variables
    private var dayLabelText: String? {
        didSet {
            if let dayLabelText = dayLabelText {
                dayLabel.text = dayLabelText
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
        if appearance.selectionCircleRadius == nil {
            appearance.selectionCircleRadius = (frame.height / 2) * 0.8
        }
        if appearance.dotMarkOffsetFromDateCenter == nil {
            appearance.dotMarkOffsetFromDateCenter = (frame.height / 2) * 0.8 - appearance.dotMarkRadius! - 2
        }
        let selectionViewFrame = CGRectMake(0, 0, frame.width, frame.height)
        selectionView = YFCustomizedShape(dayView: self, shape: .CircleWithFill, frame: selectionViewFrame)
        let dotFrame = CGRectMake(0, 0, frame.width, frame.height)
        dotView = YFCustomizedShape(dayView: self, shape: .UnselectedDotMarks, frame: dotFrame)
        dotView.colors = appearance.delegate?.calendarView?(calendarView, initializeDotsForTheDay: self)
        dotView.setNeedsDisplay()
        lineView = YFCustomizedShape(dayView: self, shape: .TopLine, frame: dotFrame)
        selectionView.alpha = 0
        if appearance.showTopLine! {
            lineView.alpha = 1
        } else {
            lineView.alpha = 0
        }
        addSubview(selectionView!)

        dayLabel.frame = bounds
        addSubview(dayLabel)
        contentView.frame = bounds
        addSubview(contentView)
        addSubview(dotView)
        addSubview(lineView)
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
                                        self.selectionView.transform = CGAffineTransformMakeScale(0.01, 0.01)
                                        self.dayLabel!.transform = CGAffineTransformMakeScale(1, 1)

            }) { _ in
                if self.date != NSDate().YFStandardFormatDate() {
                    self.selectionView?.alpha = 0
                }
            }
        }
    }
}
