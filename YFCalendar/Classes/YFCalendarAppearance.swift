//
//  CalendarAppearance.swift
//  Calendar
//
//  Created by Yangfan Liu on 23/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//

import UIKit
import Foundation

final public class YFCalendarAppearance: NSObject {
    
    var weekHeight: CGFloat = 0
    var dayWidth: CGFloat = 0

    var colorOfWeekday: UIColor? = .blackColor()
    var colorOfWeekend: UIColor? = .lightGrayColor()

    var colorOfDateInsideMonth: UIColor? = .blackColor()
    var colorOfDateOutsideMonth: UIColor? = .lightGrayColor()
    var colorOfDateToday: UIColor? = .redColor()
    var fontOfDateLabel: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())

    var selectionCircleRadius: CGFloat? = 0
    var selectionCircleBorderWidth: CGFloat? = 1
    
    var selectionCircleBorderColorInsideMonth: UIColor? = .blackColor()
    var selectionCircleFillColorInsideMonth: UIColor? = .blackColor()
    var selectionCircleBorderColorOutsideMonth: UIColor? = .lightGrayColor()
    var selectionCircleFillColorOutsideMonth: UIColor? = .lightGrayColor()
    var selectionCircleBorderColorToday: UIColor? = .redColor()
    var selectionCircleFillColorToday: UIColor? = .redColor()
    
    var dotMarkRadius: CGFloat? = 1
    var dotMarkSelectedColor: UIColor? = .whiteColor()
    var dotMarkOffsetFromDateLabel: CGFloat? = 1
    var distanceBetweenDots: CGFloat? = 2
    
    var topLineColor: UIColor? = .lightGrayColor()
    var topLineThickness: CGFloat? = 1
    var showTopLine: Bool? = true
    
    unowned let calendarView: YFCalendarView
    
    weak var delegate: YFCalendarAppearanceDelegate? {
        didSet {
            setupAppearance()
        }
    }
    
    init(calendarView: YFCalendarView) {
        self.calendarView = calendarView
        super.init()
    }
    
    func setupAppearance() {
        colorOfWeekday ~> delegate?.calendarViewSetColorForWeekday?(calendarView)
        colorOfWeekend ~> delegate?.calendarViewSetColorForWeekend?(calendarView)
        colorOfDateInsideMonth ~> delegate?.calendarViewSetColorForDate?(calendarView, dateType: .InsideCurrentMonth)
        colorOfDateOutsideMonth ~> delegate?.calendarViewSetColorForDate?(calendarView, dateType: .OutsideCurrentMonth)
        colorOfDateToday ~> delegate?.calendarViewSetColorForDate?(calendarView, dateType: .Today)
        fontOfDateLabel ~> delegate?.calendarViewSetFontForDateLabel?(calendarView)
        selectionCircleRadius ~> delegate?.calendarViewSetSelectionCircleRadius?(calendarView)
        selectionCircleBorderWidth ~> delegate?.calendarViewSetSelectionCircleBorderWidth?(calendarView)
        selectionCircleBorderColorInsideMonth ~> delegate?.calendarViewSetSelectionCircleBorderColor?(calendarView, dateType: .InsideCurrentMonth)
        selectionCircleBorderColorOutsideMonth ~> delegate?.calendarViewSetSelectionCircleBorderColor?(calendarView, dateType: .OutsideCurrentMonth)
        selectionCircleBorderColorToday ~> delegate?.calendarViewSetSelectionCircleBorderColor?(calendarView, dateType: .Today)
        selectionCircleFillColorInsideMonth ~> delegate?.calendarViewSetSelectionCircleFillColor?(calendarView, dateType: .InsideCurrentMonth)
        selectionCircleFillColorOutsideMonth ~> delegate?.calendarViewSetSelectionCircleFillColor?(calendarView, dateType: .OutsideCurrentMonth)
        selectionCircleFillColorToday ~> delegate?.calendarViewSetSelectionCircleFillColor?(calendarView, dateType: .Today)
        dotMarkRadius ~> delegate?.calendarViewSetDotMarkRadius?(calendarView)
        dotMarkSelectedColor ~> delegate?.calendarViewSetDotMarkSelectedColor?(calendarView)
        distanceBetweenDots ~> delegate?.calendarViewSetDistanceBetweenDots?(calendarView)
        dotMarkOffsetFromDateLabel ~> delegate?.calendarViewSetDotMarkOffsetFromDateLabel?(calendarView)
        topLineColor ~> delegate?.calendarViewSetTopLineColor?(calendarView)
        topLineThickness ~> delegate?.calendarViewSetTopLineThickness?(calendarView)
        showTopLine ~> delegate?.calendarViewShowTopLine?(calendarView)
    }
}

infix operator ~> { }
public func ~> <T: Any>(inout lhs: T?, rhs: T?) -> T? {
    if lhs != nil && rhs != nil {
        lhs = rhs
    }
    return lhs
}

//
