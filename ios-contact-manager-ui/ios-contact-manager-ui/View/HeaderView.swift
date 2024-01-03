
import UIKit

// MARK: - HeaderView init & deinit
class HeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeaderView()
    }
}

// MARK: - Setup HeaderView
private extension HeaderView {
    func setupHeaderView() {
        let bundle = Bundle(for: HeaderView.self)
        bundle.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: self.topAnchor),
            leadingAnchor.constraint(equalTo: self.leadingAnchor),
            trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
