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

    var colorOfDateInsideMonth: UIColor? = .blackColor()
    var colorOfDateOutsideMonth: UIColor? = .lightGrayColor()
    var colorOfDateToday: UIColor? = .redColor()
    var colorOfDateInsideMonthWhenSelected: UIColor? = .whiteColor()
    var colorOfDateOutsideMonthWhenSelected: UIColor? = .whiteColor()
    var colorOfDateTodayWhenSelected: UIColor? = .whiteColor()
    
    var fontOfDateInsideMonth: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    var fontOfDateOutsideMonth: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    var fontOfDateToday: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    var fontOfDateInsideMonthWhenSelected: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    var fontOfDateOutsideMonthWhenSelected: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    var fontOfDateTodayWhenSelected: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())

    var selectionCircleRadius: CGFloat?
    var selectionCircleBorderWidth: CGFloat? = 1
    
    var selectionCircleBorderColorInsideMonth: UIColor? = .blackColor()
    var selectionCircleFillColorInsideMonth: UIColor? = .blackColor()
    
    var selectionCircleBorderColorOutsideMonth: UIColor? = .lightGrayColor()
    var selectionCircleFillColorOutsideMonth: UIColor? = .lightGrayColor()
    
    var selectionCircleBorderColorToday: UIColor? = .redColor()
    var selectionCircleFillColorToday: UIColor? = .redColor()
    
    var dotMarkRadius: CGFloat? = 1
    var dotMarkSelectedColor: UIColor? = .whiteColor()
    var dotMarkOffsetFromDateCenter: CGFloat?
    var distanceBetweenDots: CGFloat? = 3
    
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
        colorOfDateInsideMonth ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .InsideCurrentMonth, dateState: .Noselected)
        colorOfDateOutsideMonth ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .OutsideCurrentMonth, dateState: .Noselected)
        colorOfDateToday ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .Today, dateState: .Noselected)
        colorOfDateInsideMonthWhenSelected ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .InsideCurrentMonth, dateState: .Selected)
        colorOfDateOutsideMonthWhenSelected ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .OutsideCurrentMonth, dateState: .Selected)
        colorOfDateTodayWhenSelected ~> delegate?.calendarViewSetColorForDateContent?(calendarView, dateType: .Today, dateState: .Selected)
        
        fontOfDateInsideMonth ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .InsideCurrentMonth, dateState: .Noselected)
        fontOfDateOutsideMonth ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .OutsideCurrentMonth, dateState: .Noselected)
        fontOfDateToday ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .Today, dateState: .Noselected)
        fontOfDateInsideMonthWhenSelected ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .InsideCurrentMonth, dateState: .Selected)
        fontOfDateOutsideMonthWhenSelected ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .OutsideCurrentMonth, dateState: .Selected)
        fontOfDateTodayWhenSelected ~> delegate?.calendarViewSetFontForDateContent?(calendarView, dateType: .Today, dateState: .Selected)
        
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
        dotMarkOffsetFromDateCenter ~> delegate?.calendarViewSetDotMarkOffsetFromDateCenter?(calendarView)
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
