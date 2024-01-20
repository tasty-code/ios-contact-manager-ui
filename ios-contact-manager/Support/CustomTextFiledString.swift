import Foundation

enum CustomTextFieldString: CustomStringConvertible {

    case nameText
    case ageText
    case phoneNumberText

    var description: String {
        switch self {
        case .nameText:
            return "이름"
        case .ageText:
            return "나이"
        case .phoneNumberText:
            return "연락처"
        }
    }
}
