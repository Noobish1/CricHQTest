import UIKit
import Then
import Kingfisher
import Rswift

// MARK: MoviesViewController
internal final class MoviesViewController: UIViewController {
    // MARK: properties
    private let reuseIdentifier = "MovieCell"
    private let movies: [MovieViewModel]
    private lazy var tableView = UITableView(frame: UIScreen.main.bounds).then {
        $0.dataSource = self
        $0.delegate = self
        $0.estimatedRowHeight = 124
        $0.rowHeight = UITableViewAutomaticDimension
        $0.register(R.nib.movieTableViewCell)
        $0.separatorStyle = .none
        $0.backgroundColor = .charcoal
    }
    
    // MARK: init/deinit
    internal init(movies: [MovieWithMetadata]) {
        self.movies = movies.map(MovieViewModel.init)
        
        super.init(nibName: nil, bundle: nil)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: configuration
    private func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavBar()
    }
}

// MARK: UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.nb_dequeueReusableCellWithIdentifier(R.reuseIdentifier.movieCell, indexPath: indexPath)
        cell.configure(with: movie)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let navController = self.navigationController else {
            fatalError("\(self) should be embedded in a UINavigationController but isn't")
        }
        
        let vc = MovieDetailViewController(movie: movies[indexPath.row])
        
        navController.pushViewController(vc, animated: true)
    }
}
