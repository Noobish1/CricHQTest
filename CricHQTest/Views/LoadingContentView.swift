import UIKit

internal final class LoadingContentView: UIView {
    // MARK: properties
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
    }
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // MARK: init/deinit
    internal init(title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        
        setupViews()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: update
    internal func update(title: String) {
        titleLabel.text = title
    }
    
    // MARK: animating
    internal func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    internal func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
