import UIKit

internal final class MovieDetailViewController: UIViewController {
    // MARK: outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var topContentView: UIView!
    
    // MARK: properties
    private let movie: MovieViewModel
    
    // MARK: init/deinit
    internal init(movie: MovieViewModel) {
        self.movie = movie
        
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        
        self.title = NSLocalizedString("Details", comment: "")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel.text = movie.name
        directorLabel.text = movie.director
        categoryLabel.text = movie.category
        releaseDateLabel.text = movie.releaseDate
        priceLabel.text = movie.price
        summaryLabel.text = movie.summary
        posterImageView.image = movie.image
        
        if let colors = movie.colors {
            view.backgroundColor = colors.background
            topContentView.backgroundColor = colors.background
            
            configure(label: titleLabel, withBackground: .clear, foreground: colors.primary)
            configure(label: directorLabel, withBackground: .clear, foreground: colors.primary)
            configure(label: categoryLabel, withBackground: colors.background, foreground: colors.secondary)
            configure(label: releaseDateLabel, withBackground: colors.background, foreground: colors.secondary)
            configure(label: priceLabel, withBackground: .clear, foreground: colors.secondary)
            configure(label: summaryLabel, withBackground: colors.background, foreground: colors.detail)
        }
    }
    
    // MARK: configuration
    private func configure(label: UILabel, withBackground background: UIColor, foreground: UIColor) {
        label.backgroundColor = background
        label.textColor = foreground
    }
}
