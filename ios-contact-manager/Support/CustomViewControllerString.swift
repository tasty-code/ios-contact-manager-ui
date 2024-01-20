import Foundation

enum CustomViewControllerString: CustomStringConvertible {

    case cellNameText
    case contactListTitleText
    case detailTitleText
    case fatalErrorText
    case traillingSwipeActionText
    
    var description: String {
        switch self {
        case .cellNameText:
            return "contactCell"
        case .contactListTitleText:
            return "연락처"
        case .detailTitleText:
            return "새 연락처"
        case .fatalErrorText:
            return "init(coder:) has not been implemented"
        case .traillingSwipeActionText:
            return "delete"
        }
    }
}
