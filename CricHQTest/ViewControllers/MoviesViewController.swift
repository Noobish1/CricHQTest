import UIKit

internal final class MoviesViewController: UIViewController {
    // MARK: properties
    private let topMovies: TopMovies
    
    // MARK: init/deinit
    internal init(movies: TopMovies) {
        self.topMovies = movies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .magenta
    }
}
