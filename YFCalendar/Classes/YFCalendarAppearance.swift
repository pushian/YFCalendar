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
    
    var showDateOutsideOfTheCurrentMonth: Bool? = true
    
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

    weak var delegate: YFCalendarAppearanceDelegate? {
        didSet {
            setupAppearance()
        }
    }
    
    func setupAppearance() {
        showDateOutsideOfTheCurrentMonth ~> delegate?.showDateOutsideOfTheCurrentMonth?()
        colorOfWeekday ~> delegate?.colorOfWeekday?()
        colorOfWeekend ~> delegate?.colorOfWeekend?()
        colorOfDateInsideMonth ~> delegate?.colorOfDateInsideMonth?()
        colorOfDateOutsideMonth ~> delegate?.colorOfDateOutsideMonth?()
        colorOfDateToday ~> delegate?.colorOfDateToday?()
        fontOfDateLabel ~> delegate?.fontOfDateLabel?()
        selectionCircleRadius ~> delegate?.selectionCircleRadius?()
        selectionCircleBorderWidth ~> delegate?.selectionCircleBorderWidth?()
        selectionCircleBorderColorInsideMonth ~> delegate?.selectionCircleBorderColorInsideMonth?()
        selectionCircleFillColorInsideMonth ~> delegate?.selectionCircleFillColorInsideMonth?()
        selectionCircleBorderColorOutsideMonth ~> delegate?.selectionCircleBorderColorOutsideMonth?()
        selectionCircleFillColorOutsideMonth ~> delegate?.selectionCircleFillColorOutsideMonth?()
        selectionCircleBorderColorToday ~> delegate?.selectionCircleBorderColorToday?()
        selectionCircleFillColorToday ~> delegate?.selectionCircleFillColorToday?()

        dotMarkRadius ~> delegate?.dotMarkRadius?()
        dotMarkSelectedColor ~> delegate?.dotMarkSelectedColor?()
        distanceBetweenDots ~> delegate?.distanceBetweenDots?()
        dotMarkOffsetFromDateLabel ~> delegate?.dotMarkOffsetFromDateLabel?()
        topLineColor ~> delegate?.topLineColor?()
        topLineThickness ~> delegate?.topLineThickness?()
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
