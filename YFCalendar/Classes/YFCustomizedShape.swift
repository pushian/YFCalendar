//
//  CustomizedShape.swift
//  Calendar
//
//  Created by Yangfan Liu on 26/4/16.
//  Copyright © 2016 Yangfan Liu. All rights reserved.
//
import UIKit


public class YFCustomizedShape: UIView {
    unowned let dayView: YFDayView
    unowned let weekView: YFWeekView
    unowned let monthView: YFMonthView
    unowned let calendarView: YFCalendarView
    unowned let appearance: YFCalendarAppearance
    
    var shape: ShapeType!
    var path: UIBezierPath!
    var strokeColor: UIColor?
    var fillColor: UIColor?
    
    init(dayView: YFDayView, shape: ShapeType, frame: CGRect) {
        self.dayView = dayView
        weekView = self.dayView.weekView
        monthView = weekView.monthView
        calendarView = monthView.calendarView
        appearance = calendarView.appearance!
        self.shape = shape
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func drawRect(rect: CGRect) {
        if let shape = shape {
            switch shape {
            case .CircleWithFill:
                path = circlePath(appearance.selectionCircleRadius!, offset: 0)
                path.lineWidth = appearance.selectionCircleBorderWidth!
                if dayView.date == NSDate().YFStandardFormatDate() {
                    strokeColor = appearance.selectionCircleBorderColorToday
                    fillColor = appearance.selectionCircleFillColorToday
                } else {
                    if dayView.isInside! {
                        strokeColor = appearance.selectionCircleBorderColorInsideMonth
                        fillColor = appearance.selectionCircleFillColorInsideMonth
                    } else {
                        strokeColor = appearance.selectionCircleBorderColorOutsideMonth
                        fillColor = appearance.selectionCircleFillColorOutsideMonth
                    }
                }
            case .CircleWithOutFill:
                path = circlePath(appearance.selectionCircleRadius!, offset: 0)
                path.lineWidth = appearance.selectionCircleBorderWidth!
                if dayView.date == NSDate().YFStandardFormatDate() {
                    strokeColor = appearance.selectionCircleBorderColorToday
                    fillColor = UIColor.clearColor()
                } else {
                    if dayView.isInside! {
                        strokeColor = appearance.selectionCircleBorderColorInsideMonth
                        fillColor = UIColor.clearColor()
                    } else {
                        strokeColor = appearance.selectionCircleBorderColorOutsideMonth
                        fillColor = UIColor.clearColor()
                    }
                }
            case .UnselectedDotMark:
                path = circlePath(appearance.dotMarkRadius!, offset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                strokeColor = appearance.dotMarkUnselectedColor
                fillColor = appearance.dotMarkUnselectedColor
            case .SelectedDotMark:
                path = circlePath(appearance.dotMarkRadius!, offset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                strokeColor = appearance.dotMarkSelectedColor
                fillColor = appearance.dotMarkSelectedColor
            }
        }
        
        strokeColor!.setStroke()
        fillColor!.setFill()
        path.stroke()
        path.fill()
    }
    
    func circlePath(radius: CGFloat, offset: CGFloat) -> UIBezierPath {
        let arcCenter = CGPoint(x: frame.width / 2, y: frame.height / 2 + offset)
        let startAngle = CGFloat(0)
        let endAngle = CGFloat(M_PI * 2.0)
        let clockwise = true
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius,
                                startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}
