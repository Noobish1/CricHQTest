import Foundation
import SnapKit
import Then

internal final class LoadingViewController: UIViewController {
    // MARK: properties
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
    }
    private let contentView = UIView()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    // MARK: init/deinit
    internal init(title: String = NSLocalizedString("Loading", comment: "")) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
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
        
        activityIndicator.startAnimating()
    }
    
    internal override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activityIndicator.stopAnimating()
    }
    
    // MARK: update
    internal func update(title: String) {
        titleLabel.text = title
    }
}
