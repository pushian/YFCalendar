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
    optional func dateSelectionMode() -> SelectionMode
    optional func calendarScrollDirection() -> CalendarScrollDirection
    optional func turnOnAnimationOnDay() -> Bool
    optional func autoSelectTheDayForMonthSwitchInTheSingleMode() -> Bool
    optional func didEndPrensentingTheMonth() -> Void
    optional func didEndSelectingADay(selectedDay: YFDayView) -> Void
}
