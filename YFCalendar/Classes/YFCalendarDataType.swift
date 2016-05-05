
import UIKit

public enum ShapeType {
    case CircleWithFill
    case CircleWithOutFill
    case UnselectedDotMark
    case SelectedDotMark
}

@objc public enum SelectionMode: Int {
    case Single = 1
    case Multiple = 2
}

@objc public enum CalendarScrollDirection: Int {
    case Vertical = 1
    case Horizontal = 2
}
