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
    
    weak var delegate: YFCalendarViewDelegate? {
        didSet {
            setupAppearance()
        }
    }
    
    init(calendarView: YFCalendarView) {
        self.calendarView = calendarView
        super.init()
    }
    
    func setupAppearance() {
        colorOfDateInsideMonth ~> delegate?.calendarView?(calendarView, setGeneralColor: .InsideCurrentMonth, dateState: .Noselected)
        colorOfDateOutsideMonth ~> delegate?.calendarView?(calendarView, setGeneralColor: .OutsideCurrentMonth, dateState: .Noselected)
        colorOfDateToday ~> delegate?.calendarView?(calendarView, setGeneralColor: .Today, dateState: .Noselected)
        colorOfDateInsideMonthWhenSelected ~> delegate?.calendarView?(calendarView, setGeneralColor: .InsideCurrentMonth, dateState: .Selected)
        colorOfDateOutsideMonthWhenSelected ~> delegate?.calendarView?(calendarView, setGeneralColor: .OutsideCurrentMonth, dateState: .Selected)
        colorOfDateTodayWhenSelected ~> delegate?.calendarView?(calendarView, setGeneralColor: .Today, dateState: .Selected)
        
        fontOfDateInsideMonth ~> delegate?.calendarView?(calendarView, SetGeneralFont: .InsideCurrentMonth, dateState: .Noselected)
        fontOfDateOutsideMonth ~> delegate?.calendarView?(calendarView, SetGeneralFont: .OutsideCurrentMonth, dateState: .Noselected)
        fontOfDateToday ~> delegate?.calendarView?(calendarView, SetGeneralFont: .Today, dateState: .Noselected)
        fontOfDateInsideMonthWhenSelected ~> delegate?.calendarView?(calendarView, SetGeneralFont: .InsideCurrentMonth, dateState: .Selected)
        fontOfDateOutsideMonthWhenSelected ~> delegate?.calendarView?(calendarView, SetGeneralFont: .OutsideCurrentMonth, dateState: .Selected)
        fontOfDateTodayWhenSelected ~> delegate?.calendarView?(calendarView, SetGeneralFont: .Today, dateState: .Selected)
        
        selectionCircleRadius ~> delegate?.calendarViewSetSelectionCircleRadius?(calendarView)
        selectionCircleBorderWidth ~> delegate?.calendarViewSetSelectionCircleBorderWidth?(calendarView)
        selectionCircleBorderColorInsideMonth ~> delegate?.calendarView?(calendarView, SetSelectionCircleBorderColor: .InsideCurrentMonth)
        selectionCircleBorderColorOutsideMonth ~> delegate?.calendarView?(calendarView, SetSelectionCircleBorderColor: .OutsideCurrentMonth)
        selectionCircleBorderColorToday ~> delegate?.calendarView?(calendarView, SetSelectionCircleBorderColor: .Today)
        selectionCircleFillColorInsideMonth ~> delegate?.calendarView?(calendarView, SetSelectionCircleFillColor: .InsideCurrentMonth)
        selectionCircleFillColorOutsideMonth ~> delegate?.calendarView?(calendarView, SetSelectionCircleFillColor: .OutsideCurrentMonth)
        selectionCircleFillColorToday ~> delegate?.calendarView?(calendarView, SetSelectionCircleFillColor: .Today)
        
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