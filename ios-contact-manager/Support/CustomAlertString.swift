import Foundation

enum CustomAlertString: CustomStringConvertible {
    
    case alertActionOkText
    case alertActionYesText
    case alertActionNoText
    
    case isEmptyNameAlertMessage
    case wrongNameAlertMessage
    case wrongAgeAlertMessage
    case wrongPhoneNumberAlertMessage
    case cancelAlertMessage
    
    var description: String {
        switch self {
        case .alertActionOkText:
            return "확인"
        case .alertActionYesText:
            return "예"
        case .alertActionNoText:
            return "아니오"
            
        case .isEmptyNameAlertMessage:
            return "이름을 입력해주세요."
        case .wrongNameAlertMessage:
            return "입력한 이름 정보가 잘못되었습니다."
        case .wrongAgeAlertMessage:
            return "입력한 나이정보가 잘못되었습니다."
        case .wrongPhoneNumberAlertMessage:
            return "입력한 연락처 정보가 잘못되었습니다."
        case .cancelAlertMessage:
            return "정말 종료하시겠습니까?"
        }
    }
}
