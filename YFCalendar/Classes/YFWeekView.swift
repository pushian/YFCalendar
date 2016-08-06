//
//  WeekView.swift
//  Calendar
//
//  Created by Yangfan Liu on 21/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit

public class YFWeekView: YFCalendarBaseView {
    //MARK: - Weak Reference
    unowned let monthView: YFMonthView
    unowned let calendarView: YFCalendarView

    //MARK: - Functions Open For User
    //MARK: - Public Functions
    func findTheOwnerWithDate(date: NSDate) -> YFDayView? {
        for day in dayViews {
            if day.belongsToDate(date) {
                return day
            }
        }
        return nil
    }
    //MARK: - Private Functions
    private func loadDays() {
        for index in 0...6 {
            insertDays(index)
        }
    }
    
    private func insertDays(index: Int) {
        let dayView = YFDayView(weekView: self, dayIndex: index)
        addSubview(dayView)
        dayViews.append(dayView)
        dayView.translatesAutoresizingMaskIntoConstraints = false
        if index == 0 {
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Top,
                relatedBy: .Equal, toItem: self, attribute: .Top,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Bottom,
                relatedBy: .Equal, toItem: self, attribute: .Bottom,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Leading,
                relatedBy: .Equal, toItem: self, attribute: .Leading,
                multiplier: 1, constant: 0))
        } else if index == 6 {
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Top,
                relatedBy: .Equal, toItem: self, attribute: .Top,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Bottom,
                relatedBy: .Equal, toItem: self, attribute: .Bottom,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Leading,
                relatedBy: .Equal, toItem: dayViews[index - 1], attribute: .Trailing,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Trailing,
                relatedBy: .Equal, toItem: self, attribute: .Trailing,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Width,
                relatedBy: .Equal, toItem: dayViews[index - 1], attribute: .Width,
                multiplier: 1, constant: 0))
        } else {
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Top,
                relatedBy: .Equal, toItem: self, attribute: .Top,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Bottom,
                relatedBy: .Equal, toItem: self, attribute: .Bottom,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Leading,
                relatedBy: .Equal, toItem: dayViews[index - 1], attribute: .Trailing,
                multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: dayView, attribute: .Width,
                relatedBy: .Equal, toItem: dayViews[index - 1], attribute: .Width,
                multiplier: 1, constant: 0))
        }
    }
    //MARK: - Variables Open For User
    //MARK: - Public Variables
    var weekIndex: Int!
    var dayViews = [YFDayView]()
    //MARK: - Private Variables
    //MARK: - Life Cycle
    init(monthView: YFMonthView, weekIndex: Int) {
        self.monthView = monthView
        calendarView = monthView.calendarView
        self.weekIndex = weekIndex
        super.init(frame: CGRectZero)
        backgroundColor = .whiteColor()
        loadDays()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
