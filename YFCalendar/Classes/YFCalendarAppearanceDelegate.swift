//
//  CalendarAppearanceDelegate.swift
//  Calendar
//
//  Created by Yangfan Liu on 25/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit
import Foundation

@objc
public protocol YFCalendarAppearanceDelegate: class {
    //
    optional func calendarViewSetColorForWeekday(calenderView: YFCalendarView) -> UIColor // only valid when the date outside of the month is hidden
    optional func calendarViewSetColorForWeekend(calenderView: YFCalendarView) -> UIColor // only valid when the date outside of the month is hidden
    
    optional func calendarViewSetColorForDate(calenderView: YFCalendarView, dateType: DateType) -> UIColor
    optional func calendarViewSetFontForDateLabel(calenderView: YFCalendarView) -> UIFont
    
    optional func calendarViewSetSelectionCircleRadius(calenderView: YFCalendarView) -> CGFloat
    optional func calendarViewSetSelectionCircleBorderWidth(calenderView: YFCalendarView) -> CGFloat
    
    optional func calendarViewSetSelectionCircleBorderColor(calenderView: YFCalendarView, dateType: DateType) -> UIColor
    
    optional func calendarViewSetSelectionCircleFillColor(calenderView: YFCalendarView, dateType: DateType) -> UIColor
    
    optional func calendarViewSetDotMarkRadius(calenderView: YFCalendarView) -> CGFloat
    optional func calendarViewSetDotMarkOffsetFromDateLabel(calenderView: YFCalendarView) -> CGFloat
    
    /*If the slected color of the dot marks is set to be UIColor.clearColor(),
      there color of the dot marks in the selection mode will be the same with the unselection mode.
    */
    optional func calendarViewSetDotMarkSelectedColor(calenderView: YFCalendarView) -> UIColor
    optional func calendarViewSetDistanceBetweenDots(calenderView: YFCalendarView) -> CGFloat
    
    
    optional func calendarViewSetTopLineColor(calenderView: YFCalendarView) -> UIColor
    optional func calendarViewSetTopLineThickness(calenderView: YFCalendarView) -> CGFloat
    optional func calendarViewShowTopLine(calenderView: YFCalendarView) -> Bool
    
    //DayView Customization
    optional func calendarView(calenderView: YFCalendarView, customizeColorForTheDay theDay: YFDayView) -> UIColor?
    optional func calendarView(calenderView: YFCalendarView, initializeDotsForTheDay theDay: YFDayView) -> [UIColor]?
    optional func calendarView(calenderView: YFCalendarView, disableUserInteractionForTheDay theDay: YFDayView) -> Bool
}
