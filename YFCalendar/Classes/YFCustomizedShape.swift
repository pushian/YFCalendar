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
                let pathOne = circlePath(appearance.selectionCircleRadius!, xOffset: 0, yOffset: 0)
                pathOne.lineWidth = appearance.selectionCircleBorderWidth!
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
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne.stroke()
                pathOne.fill()
                
            case .CircleWithOutFill:
                let pathOne = circlePath(appearance.selectionCircleRadius!, xOffset: 0, yOffset: 0)
                pathOne.lineWidth = appearance.selectionCircleBorderWidth!
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
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne.stroke()
                pathOne.fill()
            case .UnselectedDotMarks:
                if let colors = colors {
                    if colors.count > 0 {
                        var start = -CGFloat(colors.count - 1) * (appearance.distanceBetweenDots! / 2.0)
                        var yOff = dayView.dayLabel.frame.height / 2.0 + appearance.dotMarkOffsetFromDateLabel!
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
                        var yOff = dayView.dayLabel.frame.height / 2.0 + appearance.dotMarkOffsetFromDateLabel!
                        for each in colors {
                            let path = circlePath(appearance.dotMarkRadius!, xOffset: start, yOffset: yOff)
                            start += appearance.distanceBetweenDots!
                            if appearance.dotMarkSelectedColor != .clearColor() {
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
        debugPrint(radius)
        debugPrint(xOffset)
        debugPrint("---------")
        let arcCenter = CGPoint(x: frame.width / 2.0 + xOffset, y: frame.height / 2.0 + yOffset)
        let startAngle = CGFloat(0)
        let endAngle = CGFloat(M_PI * 2.0)
        let clockwise = true
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius,
                                startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}
