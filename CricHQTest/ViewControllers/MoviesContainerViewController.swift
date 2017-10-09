import UIKit
import SnapKit
import Then
import RxSwift

internal final class MoviesContainerViewController: UIViewController, StatefulContainerViewController {
    // MARK: state
    internal enum State: ContainerStateProtocol {
        case loading(LoadingViewController)
        case errored(ErrorViewController)
        case loaded(MoviesViewController)
        
        internal static func == (lhs: State, rhs: State) -> Bool {
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
        
        internal var viewController: UIViewController {
            switch self {
                case .loading(let vc): return vc
                case .errored(let vc): return vc
                case .loaded(let vc): return vc
            }
        }
    }
    
    // MARK: properties
    private let disposeBag = DisposeBag()
    private let initialFetch = Singular()
    private lazy var dataFetcher = MoviesDataFetcher().then {
        $0.delegate = self
    }
    
    internal let containerView = UIView()
    internal var state: State = .loading(LoadingViewController())
    
    // MARK: init/deinit
    internal init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = NSLocalizedString("Top Movies", comment: "")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContainerView()
        setupInitialViewController(state.viewController, containerView: containerView)
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialFetch.performOnce {
            fetchData()
        }
    }
    
    // MARK: fetch
    private func fetchData(minimumDuration: RxTimeInterval = 0) {
        transition(to: .loading(LoadingViewController()))
        
        dataFetcher.fetchTopMoviesWithMetadata()
            .minimumDuration(duration: minimumDuration)
            .subscribe { [weak self] event in
                guard let strongSelf = self else { return }
                
                switch event {
                    case .success(let movies):
                        strongSelf.transition(to: .loaded(MoviesViewController(movies: movies)))
                    case .error:
                        strongSelf.transition(to: .errored(ErrorViewController(onTap: { [weak self] in
                            guard let strongSelf = self else { return }
                            
                            // Minimum duration of 0.6 so a fast load doesn't flicker the UI
                            strongSelf.fetchData(minimumDuration: 0.6)
                        })))
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: update
    private func updateLoadingTitleIfNeeded(to title: String) {
        switch state {
            case .loading(let loadingVC): loadingVC.update(title: title)
            case .errored, .loaded: break
        }
    }
}

extension MoviesContainerViewController: MoviesDataFetcherDelegate {
    internal func dataFetcherDidStartFetchingInitialData(dataFetcher: MoviesDataFetcher) {
        updateLoadingTitleIfNeeded(to: NSLocalizedString("Fetching Initial Data", comment: ""))
    }
    
    internal func dataFetcherDidStartFetchingImages(dataFetcher: MoviesDataFetcher) {
        updateLoadingTitleIfNeeded(to: NSLocalizedString("Fetching Images", comment: ""))
    }
    
    internal func dataFetcherDidStartProcessingImages(dataFetcher: MoviesDataFetcher) {
        updateLoadingTitleIfNeeded(to: NSLocalizedString("Processing Images", comment: ""))
    }
}
