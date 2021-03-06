
import UIKit

public enum ShapeType {
    case CircleWithFill
    case UnselectedDotMarks
    case SelectedDotMarks
    case TopLine
}

@objc public enum DateType: Int {
    case InsideCurrentMonth = 1
    case OutsideCurrentMonth = 2
    case Today = 3
}

@objc public enum DateState: Int {
    case Selected = 0
    case Noselected = 1
}

@objc public enum SelectionMode: Int {
    case Single = 1
    case Multiple = 2
}

@objc public enum CalendarScrollDirection: Int {
    case Vertical = 1
    case Horizontal = 2
}

public struct DotedDate {
    var date: NSDate?
    var dotColors: [UIColor]?
    
    func equalsTo(object: DotedDate) -> Bool {
        return self.date == object.date
    }
}

public enum DayName: Int {
    case Sunday = 0
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
}
