import UIKit
import SwiftUI

class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(CustomViewControllerString.fatalErrorText.description)
    }
}

// MARK: PreView
struct PreView: PreviewProvider {
    static var previews: some View {
        NavigationController(rootViewController: ContactListViewController()).toPreview()
    }
}


#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
