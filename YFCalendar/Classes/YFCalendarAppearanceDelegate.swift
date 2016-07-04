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
    //MARK: - calendar view level
    //MARK: - day view level
    optional func colorOfWeekday() -> UIColor // only valid when the date outside of the month is hidden
    optional func colorOfWeekend() -> UIColor // only valid when the date outside of the month is hidden

    optional func colorOfDateInsideMonth() -> UIColor
    optional func colorOfDateOutsideMonth() -> UIColor
    optional func colorOfDateToday() -> UIColor
    optional func fontOfDateLabel() -> UIFont
    
    optional func selectionCircleRadius() -> CGFloat
    optional func selectionCircleBorderWidth() -> CGFloat
    
    optional func selectionCircleBorderColorInsideMonth() -> UIColor
    optional func selectionCircleFillColorInsideMonth() -> UIColor
    optional func selectionCircleBorderColorOutsideMonth() -> UIColor
    optional func selectionCircleFillColorOutsideMonth() -> UIColor
    optional func selectionCircleBorderColorToday() -> UIColor
    optional func selectionCircleFillColorToday() -> UIColor
    
    optional func dotMarkRadius() -> CGFloat
    optional func dotMarkOffsetFromDateLabel() -> CGFloat
    optional func dotMarkSelectedColor() -> UIColor
    optional func distanceBetweenDots() -> CGFloat
    
    
    optional func topLineColor() -> UIColor
    optional func topLineThickness() -> CGFloat
    optional func showTopLine() -> Bool

    // DayView Customization
    optional func colorOfADate(selectedDay: YFDayView) -> UIColor?
    optional func disableADate(selectedDay: YFDayView) -> Bool
}
//public protocol YFCalendarAppearanceDelegate: class {
//    //MARK: - day view level
//    optional func calendarViewSetColorForWeekday(calenderView: YFCalendarView) -> UIColor // only valid when the date outside of the month is hidden
//    optional func calendarViewSetColorForWeekend(calenderView: YFCalendarView) -> UIColor // only valid when the date outside of the month is hidden
//    
//    //    optional func calendarViewSetColorForDateInsideMonth(calenderView: YFCalendarView) -> UIColor
//    //    optional func calendarViewSetColorForDateOutsideMonth(calenderView: YFCalendarView) -> UIColor
//    //    optional func calendarViewSetColorForToday(calenderView: YFCalendarView) -> UIColor
//    optional func calendarViewSetColorForDate(calenderView: YFCalendarView, dateType: DateType) -> UIColor
//    optional func calendarViewSetFontForDateLabel(calenderView: YFCalendarView) -> UIFont
//    
//    optional func calendarViewSetSelectionCircleRadius(calenderView: YFCalendarView) -> CGFloat
//    optional func calendarViewSetSelectionCircleBorderWidth(calenderView: YFCalendarView) -> CGFloat
//    
//    //    optional func calendarViewSetSelectionCircleBorderColorInsideMonth() -> UIColor
//    //    optional func calendarViewSetSelectionCircleBorderColorOutsideMonth() -> UIColor
//    //    optional func calendarViewSetSelectionCircleBorderColorToday() -> UIColor
//    optional func calendarViewSetSelectionCircleBorderColor(calenderView: YFCalendarView, dateType: DateType) -> UIColor
//    
//    //    optional func calendarViewSetSelectionCircleFillColorInsideMonth() -> UIColor
//    //    optional func calendarViewSetSelectionCircleFillColorOutsideMonth() -> UIColor
//    //    optional func calendarViewSetSelectionCircleFillColorToday() -> UIColor
//    optional func calendarViewSetSelectionCircleFillColor(calenderView: YFCalendarView, dateType: DateType) -> UIColor
//    
//    optional func calendarViewSetDotMarkRadius(calenderView: YFCalendarView) -> CGFloat
//    optional func calendarViewSetDotMarkOffsetFromDateLabel(calenderView: YFCalendarView) -> CGFloat
//    optional func calendarViewSetDotMarkSelectedColor(calenderView: YFCalendarView) -> UIColor
//    optional func calendarViewSetDistanceBetweenDots(calenderView: YFCalendarView) -> CGFloat
//    
//    
//    optional func calendarViewSetTopLineColor(calenderView: YFCalendarView) -> UIColor
//    optional func calendarViewSetTopLineThickness(calenderView: YFCalendarView) -> CGFloat
//    optional func calendarViewShowTopLine(calenderView: YFCalendarView) -> Bool
//    
//    // DayView Customization
//    optional func calendarView(calenderView: YFCalendarView, customizeColorForTheDay: YFDayView) -> UIColor?
//    optional func calendarView(calenderView: YFCalendarView, disableUserInteractionForTheDay: YFDayView) -> Bool
//}
