import Foundation
import SnapKit
import Then

internal final class LoadingViewController: UIViewController {
    // MARK: properties
    private let contentView: LoadingContentView
    
    // MARK: init/deinit
    internal init(title: String = NSLocalizedString("Loading", comment: "")) {
        self.contentView = LoadingContentView(title: title)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.backgroundColor = .charcoal
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.startAnimating()
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        contentView.stopAnimating()
    }
    
    // MARK: update
    internal func update(title: String) {
        contentView.update(title: title)
    }
}
