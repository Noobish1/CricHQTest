import Foundation
import SnapKit

internal final class LoadingViewController: UIViewController {
    // MARK: properties
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    // MARK: setup
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
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
}
