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
    var pathOne: UIBezierPath?
    var pathTwo: UIBezierPath?
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
                pathOne = circlePath(appearance.selectionCircleRadius!, xOffset: 0, yOffset: 0)
                pathOne!.lineWidth = appearance.selectionCircleBorderWidth!
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
                pathOne!.stroke()
                pathOne!.fill()
                
            case .CircleWithOutFill:
                pathOne = circlePath(appearance.selectionCircleRadius!, xOffset: 0, yOffset: 0)
                pathOne!.lineWidth = appearance.selectionCircleBorderWidth!
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
                pathOne!.stroke()
                pathOne!.fill()
                
            case .UnselectedSingleDotMark:
                pathOne = circlePath(appearance.dotMarkRadius!, xOffset: 0, yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                
                strokeColor = colors![0]
                fillColor = colors![0]
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne!.stroke()
                pathOne!.fill()
                
            case .SelectedSingleDotMark:
                pathOne = circlePath(appearance.dotMarkRadius!, xOffset: 0, yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                
                strokeColor = appearance.dotMarkSelectedColor
                fillColor = appearance.dotMarkSelectedColor
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne!.stroke()
                pathOne!.fill()
                
            case .UnselectedDoubleDotMark:
                pathOne = circlePath(appearance.dotMarkRadius!, xOffset: -(appearance.dotMarkRadius! + appearance.distanceBetweenDots! / 2), yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                pathTwo = circlePath(appearance.dotMarkRadius!, xOffset: (appearance.dotMarkRadius! + appearance.distanceBetweenDots! / 2), yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                
                strokeColor = colors![0]
                fillColor = colors![0]
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne!.stroke()
                pathOne!.fill()
                strokeColor = colors![1]
                fillColor = colors![1]
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathTwo!.stroke()
                pathTwo!.fill()
                
            case .SelectedDoubleDotMark:
                pathOne = circlePath(appearance.dotMarkRadius!, xOffset: -(appearance.dotMarkRadius! + appearance.distanceBetweenDots! / 2), yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                pathTwo = circlePath(appearance.dotMarkRadius!, xOffset: (appearance.dotMarkRadius! + appearance.distanceBetweenDots! / 2), yOffset: dayView.dayLabel.frame.height / 2 + appearance.dotMarkOffsetFromDateLabel!)
                
                strokeColor = appearance.dotMarkSelectedColor
                fillColor = appearance.dotMarkSelectedColor
                strokeColor!.setStroke()
                fillColor!.setFill()
                pathOne!.stroke()
                pathOne!.fill()
                pathTwo!.stroke()
                pathTwo!.fill()
                
            case .TopLine:
                pathOne = UIBezierPath()
                pathOne!.lineWidth = appearance.topLineThickness!
                appearance.topLineColor!.setStroke()
                pathOne!.moveToPoint(CGPoint(x: 0, y: 0))
                pathOne!.addLineToPoint(CGPoint(x: bounds.width, y: 0))
                pathOne!.closePath()
                pathOne!.stroke()
                debugPrint(dayView.date)
                debugPrint(bounds.width)
            case .None:
                break
            }
        }

    }
    
    func circlePath(radius: CGFloat, xOffset: CGFloat, yOffset: CGFloat) -> UIBezierPath {
        let arcCenter = CGPoint(x: frame.width / 2 + xOffset, y: frame.height / 2 + yOffset)
        let startAngle = CGFloat(0)
        let endAngle = CGFloat(M_PI * 2.0)
        let clockwise = true
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius,
                                startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}
