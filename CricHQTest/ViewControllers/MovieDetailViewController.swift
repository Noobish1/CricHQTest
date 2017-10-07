import UIKit

internal final class MovieDetailViewController: UIViewController {
    // MARK: properties
    private let movie: Movie
    
    // MARK: init/deinit
    internal init(movie: Movie) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = movie.name
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
