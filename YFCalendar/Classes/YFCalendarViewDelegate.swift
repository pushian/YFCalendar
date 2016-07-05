//
//  CalendarViewDelegate.swift
//  Calendar
//
//  Created by Yangfan Liu on 25/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//


import UIKit
import Foundation

@objc
public protocol YFCalendarViewDelegate: class {
    optional func calendarView(calenderView: YFCalendarView, autoSelectTheFirstDateOfTheNextMonthBasedOnSelectionMode: SelectionMode) -> Bool
    optional func calendarView(calenderView: YFCalendarView, willPresentTheMonth currentMonth: YFMonthView) -> Void
    optional func calendarView(calenderView: YFCalendarView, didPresentTheMonth currentMonth: YFMonthView) -> Void
    optional func calendarView(calenderView: YFCalendarView, didSelectADay selectedDay: YFDayView) -> Void
    optional func calendarView(calenderView: YFCalendarView, didDeselectADay deselectedDay: YFDayView) -> Void

    optional func calendarViewSetDateSelectionMode(calenderView: YFCalendarView) -> SelectionMode
    optional func calendarViewSetScrollDirection(calenderView: YFCalendarView) -> CalendarScrollDirection
    optional func calendarViewTurnOnSelectionAnimation(calenderView: YFCalendarView) -> Bool
    optional func calendarViewAutoScrollToTheNewMonthWhenTabTheDateOutsideOfTheCurrentMonth(calenderView: YFCalendarView) -> Bool
    optional func calendarViewAutoSelectToday(calenderView: YFCalendarView) -> Bool
    optional func calendarViewShowDateOutsideOfTheCurrentMonth(calenderView: YFCalendarView) -> Bool
}
