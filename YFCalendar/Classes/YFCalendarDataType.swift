
import UIKit

public enum ShapeType {
    case CircleWithFill
    case CircleWithOutFill
    case UnselectedSingleDotMark
    case SelectedSingleDotMark
    case UnselectedDoubleDotMark
    case SelectedDoubleDotMark
    case None
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
