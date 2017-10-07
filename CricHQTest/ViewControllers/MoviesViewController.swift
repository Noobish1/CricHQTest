import UIKit
import Then
import Kingfisher
import Rswift

// MARK: MoviesViewController
internal final class MoviesViewController: UIViewController {
    // MARK: properties
    private let reuseIdentifier = "MovieCell"
    private let topMovies: TopMovies
    private let imagesMapping: [UUID: UIImage]
    private let colorsMapping: [UUID: CellColors]
    private lazy var tableView = UITableView(frame: UIScreen.main.bounds).then {
        $0.dataSource = self
        $0.delegate = self
        $0.estimatedRowHeight = 124
        $0.rowHeight = UITableViewAutomaticDimension
        $0.register(R.nib.movieTableViewCell)
        $0.separatorStyle = .none
    }
    
    // MARK: init/deinit
    internal init(movies: TopMoviesWithMetadata) {
        self.topMovies = movies.topMovies
        self.imagesMapping = movies.imagesMapping
        self.colorsMapping = movies.colorsMapping
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setup
    private func setupViews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topMovies.movies.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = topMovies.movies[indexPath.row]
        
        let cell = tableView.nb_dequeueReusableCellWithIdentifier(R.reuseIdentifier.movieCell, indexPath: indexPath)
        cell.configure(with: movie, image: imagesMapping[movie.id], colors: colorsMapping[movie.id])
        
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
        
        let vc = MovieDetailViewController(movie: topMovies.movies[indexPath.row])
        
        navController.pushViewController(vc, animated: true)
    }
}
