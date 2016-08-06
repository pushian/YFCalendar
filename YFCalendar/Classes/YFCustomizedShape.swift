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
    
    var shape: ShapeType?
    var colors: [UIColor]?
    var strokeColor: UIColor?
    var fillColor: UIColor?
    
    init(dayView: YFDayView, shape: ShapeType) {
        self.dayView = dayView
        weekView = self.dayView.weekView
        monthView = weekView.monthView
        calendarView = monthView.calendarView
        appearance = calendarView.appearance!
        self.shape = shape
        super.init(frame: CGRectZero)
        backgroundColor = UIColor.clearColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func drawRect(rect: CGRect) {
        if appearance.selectionCircleRadius == nil {
            appearance.selectionCircleRadius = (frame.height / 2) * 0.7
        }
        if appearance.dotMarkOffsetFromDateCenter == nil {
            appearance.dotMarkOffsetFromDateCenter = (frame.height / 2) * 0.7 - appearance.dotMarkRadius! - 2
        }
        
        if let shape = shape {
            switch shape {
            case .CircleWithFill:
                let pathOne = circlePath(appearance.selectionCircleRadius!, xOffset: 0, yOffset: 0)
                pathOne.lineWidth = appearance.selectionCircleBorderWidth!
                if dayView.date == NSDate().YFStandardFormatDate() {
                    if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleBorderColorForTheDay: dayView) {
                        strokeColor = color
                    } else {
                        strokeColor = appearance.selectionCircleBorderColorToday
                    }
                    if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleFillColorForTheDay: dayView) {
                        fillColor = color
                    } else {
                        fillColor = appearance.selectionCircleFillColorToday
                    }
                } else {
                    if dayView.isInside! {
                        if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleBorderColorForTheDay: dayView) {
                            strokeColor = color
                        } else {
                            strokeColor = appearance.selectionCircleBorderColorInsideMonth
                        }
                        if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleFillColorForTheDay: dayView) {
                            fillColor = color
                        } else {
                            fillColor = appearance.selectionCircleFillColorInsideMonth
                        }
                    } else {
                        if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleBorderColorForTheDay: dayView) {
                            strokeColor = color
                        } else {
                            strokeColor = appearance.selectionCircleBorderColorOutsideMonth
                        }
                        if let color = appearance.delegate?.calendarView?(calendarView, customizeSelectionCircleFillColorForTheDay: dayView) {
                            fillColor = color
                        } else {
                            fillColor = appearance.selectionCircleFillColorOutsideMonth
                        }
                    }
                }
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne.stroke()
                pathOne.fill()
            case .UnselectedDotMarks:
                if let colors = colors {
                    if colors.count > 0 {
                        var start = -CGFloat(colors.count - 1) * (appearance.distanceBetweenDots! / 2.0)
                        let yOff = appearance.dotMarkOffsetFromDateCenter!
                        for each in colors {
                            let path = circlePath(appearance.dotMarkRadius!, xOffset: start, yOffset: yOff)
                            strokeColor = each
                            fillColor = each
                            strokeColor!.setStroke()
                            fillColor!.setFill()
                            path.stroke()
                            path.fill()
                            start += appearance.distanceBetweenDots!
                        }
                    }
                }
            case .SelectedDotMarks:
                if let colors = colors {
                    if colors.count > 0 {
                        var start = -CGFloat(colors.count - 1) * (appearance.distanceBetweenDots! / 2.0)
                        let yOff = appearance.dotMarkOffsetFromDateCenter!
                        for each in colors {
                            let path = circlePath(appearance.dotMarkRadius!, xOffset: start, yOffset: yOff)
                            start += appearance.distanceBetweenDots!
                            if appearance.dotMarkSelectedColor != nil {
                                strokeColor = appearance.dotMarkSelectedColor
                                fillColor = appearance.dotMarkSelectedColor
                                strokeColor!.setStroke()
                                fillColor!.setFill()
                            } else {
                                strokeColor = each
                                fillColor = each
                                strokeColor!.setStroke()
                                fillColor!.setFill()
                            }
                            path.stroke()
                            path.fill()
                        }
                    }
                }
            case .TopLine:
                let pathOne = UIBezierPath()
                pathOne.lineWidth = appearance.topLineThickness!
                appearance.topLineColor!.setStroke()
                pathOne.moveToPoint(CGPoint(x: 0, y: 0))
                pathOne.addLineToPoint(CGPoint(x: bounds.width, y: 0))
                pathOne.closePath()
                pathOne.stroke()
            }
        }

    }
    
    func circlePath(radius: CGFloat, xOffset: CGFloat, yOffset: CGFloat) -> UIBezierPath {
        let arcCenter = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
        let startAngle = CGFloat(0)
        let endAngle = CGFloat(M_PI * 2.0)
        let clockwise = true
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius,
                                startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}
