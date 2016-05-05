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
    optional func showDateOutsideOfTheCurrentMonth() -> Bool
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
}
