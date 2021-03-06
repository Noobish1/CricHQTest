import UIKit

internal final class MovieDetailContentView: UIView {
    // MARK: outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var topContentView: UIView!
    @IBOutlet private weak var trailerButton: UIButton!
    
    // MARK: configuration
    internal func configure(with viewModel: MovieViewModel) {
        titleLabel.text = viewModel.name
        directorLabel.text = viewModel.director
        categoryLabel.text = viewModel.category
        releaseDateLabel.text = viewModel.releaseDate
        priceLabel.text = viewModel.price
        summaryLabel.text = viewModel.summary
        posterImageView.image = viewModel.image
        trailerButton.isHidden = viewModel.trailerURL == nil
        
        if let colors = viewModel.colors {
            configureStyle(with: colors)
        } else {
            trailerButton.tintColor = .black
        }
    }
    
    private func configureStyle(with colors: InterfaceColors) {
        topContentView.backgroundColor = colors.background
        
        configure(label: titleLabel, withBackground: .clear, foreground: colors.primary)
        configure(label: directorLabel, withBackground: .clear, foreground: colors.primary)
        configure(label: categoryLabel, withBackground: colors.background, foreground: colors.secondary)
        configure(label: releaseDateLabel, withBackground: colors.background, foreground: colors.secondary)
        configure(label: priceLabel, withBackground: .clear, foreground: colors.secondary)
        configure(label: summaryLabel, withBackground: colors.background, foreground: colors.detail)
    }
    
    private func configure(label: UILabel, withBackground background: UIColor, foreground: UIColor) {
        label.backgroundColor = background
        label.textColor = foreground
    }
}
