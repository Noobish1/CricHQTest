import UIKit
import Then

internal final class ErrorViewController: UIViewController {
    // MARK: properties
    private let label = UILabel().then {
        $0.text = NSLocalizedString("Top Movies failed to load.\nTap to try again", comment: "")
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    private let onTap: () -> Void
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    // MARK: init/deinit
    internal init(onTap: @escaping () -> Void) {
        self.onTap = onTap
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.backgroundColor = .white
        view.addGestureRecognizer(tapRecognizer)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: interface actions
    @objc
    private func viewTapped() {
        onTap()
    }
}
