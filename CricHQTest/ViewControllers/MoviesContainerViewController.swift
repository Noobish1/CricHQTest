import UIKit
import SnapKit
import Then
import RxSwift

internal final class MoviesContainerViewController: UIViewController, ContainerViewControllerProtocol {
    // MARK: state
    private enum State: Equatable {
        case loading(LoadingViewController)
        case errored(ErrorViewController)
        case loaded(MoviesViewController)
        
        fileprivate static func == (lhs: State, rhs: State) -> Bool {
            switch lhs {
                case .loading(let lhsVC):
                    switch rhs {
                        case .loading(let rhsVC): return lhsVC == rhsVC
                        default: return false
                    }
                case .errored(let lhsVC):
                    switch rhs {
                        case .errored(let rhsVC): return lhsVC == rhsVC
                        default: return false
                    }
                case .loaded(let lhsVC):
                    switch rhs {
                        case .loading(let rhsVC): return lhsVC == rhsVC
                        default: return false
                    }
            }
        }
        
        fileprivate var viewController: UIViewController {
            switch self {
                case .loading(let vc): return vc
                case .errored(let vc): return vc
                case .loaded(let vc): return vc
            }
        }
    }
    
    // MARK: properties
    private let containerView = UIView()
    private let disposeBag = DisposeBag()
    private var state: State = .loading(LoadingViewController())
    
    // MARK: init/deinit
    internal init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = NSLocalizedString("Top Movies", comment: "")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupInitialViewController(state.viewController, containerView: containerView)
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTopMovies()
    }
    
    // MARK: fetch
    private func fetchTopMovies(minimumDuration: RxTimeInterval = 0) {
        transition(to: .loading(LoadingViewController()))
        
        APIClient.shared.topMovies().minimumDuration(duration: minimumDuration).subscribe { [weak self] event in
            guard let strongSelf = self else { return }
            
            switch event {
                case .success(let movies):
                    strongSelf.transition(to: .loaded(MoviesViewController(movies: movies)))
                case .error:
                    strongSelf.transition(to: .errored(ErrorViewController(onTap: { [weak self] in
                        guard let strongSelf = self else { return }
                        
                        // Minimum duration of 0.6 so a fast load doesn't flicker the UI
                        strongSelf.fetchTopMovies(minimumDuration: 0.6)
                    })))
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: transition
    private func transition(to newState: State) {
        guard newState != state else {
            return
        }
        
        let fromVC = self.state.viewController
        let toVC = newState.viewController
        
        transitionFromViewController(fromVC, toViewController: toVC, containerView: containerView)
        
        self.state = newState
    }
}