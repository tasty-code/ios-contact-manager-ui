import UIKit

struct AlertService {
    weak var viewController: UIViewController?

    func alertInvalidInput(alertMessage: AlertService.Message) {
        guard let viewController else { return }
        let alertController = AlertBuilder()
            .addAction("확인", style: .default)
            .addMessage(message: String(describing: alertMessage), preferredStyle: .alert)
        viewController.present(alertController, animated: true)
    }
    
    func alertCancelConfirmation() {
        guard let viewController else { return }
        let cancelConfirmationMessage = AlertService.Message.cancelConfirmation
        let alertController = AlertBuilder()
            .addAction("예", style: .destructive) {
                viewController.presentingViewController?.dismiss(animated: true)
            }
            .addAction("아니오", style: .cancel)
            .addMessage(title: String(describing: cancelConfirmationMessage), preferredStyle: .alert)
        viewController.present(alertController, animated: true)
    }
}

extension AlertService {
    enum Message: CustomStringConvertible {
        case cancelConfirmation
        case invalidName
        case invalidAge
        case invalidPhoneNumber
        
        var description: String {
            switch self {
            case .cancelConfirmation:
                "정말로 취소하시겠습니까?"
            case .invalidName:
                "입력한 이름 정보가 잘못되었습니다."
            case .invalidAge:
                "입력한 나이 정보가 잘못되었습니다."
            case .invalidPhoneNumber:
                "입력한 연락처 정보가 잘못되었습니다."
            }
        }
    }
}
