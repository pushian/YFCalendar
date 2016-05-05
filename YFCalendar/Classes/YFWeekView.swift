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
        for index in 1...7 {
            insertDays(index)
        }
    }
    
    private func insertDays(index: Int) {
        let dayFrame = CGRectMake(calendarView.appearance!.dayWidth * CGFloat(index - 1), 0, calendarView.appearance!.dayWidth, calendarView.appearance!.weekHeight)
        let dayView = YFDayView(weekView: self, frame: dayFrame, dayIndex: index)
        addSubview(dayView)
        dayViews.append(dayView)
    }
    //MARK: - Variables Open For User
    //MARK: - Public Variables
    var weekIndex: Int!
    var dayViews = [YFDayView]()
    //MARK: - Private Variables
    private var topLineView: UIView?
    //MARK: - Life Cycle
    init(monthView: YFMonthView, frame: CGRect, weekIndex: Int) {
        self.monthView = monthView
        calendarView = monthView.calendarView
        self.weekIndex = weekIndex
        super.init(frame: frame)
        topLineView = UIView(frame: CGRectMake(0, 0, frame.width, calendarView.appearance!.topLineThickness!))
        topLineView?.backgroundColor = calendarView.appearance!.topLineColor!
        addSubview(topLineView!)
        loadDays()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
