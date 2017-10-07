import UIKit
import Then
import Hue

internal final class MovieTableViewCell: UITableViewCell {
    // MARK: outlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var innerContentView: UIView!
    
    // MARK: reuse
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
    
    // MARK: configuration
    private func configure(label: UILabel, withBackground background: UIColor, foreground: UIColor) {
        label.backgroundColor = background
        label.textColor = foreground
    }
    
    private func configureSelectedBackgroundView(with color: UIColor) {
        self.selectedBackgroundView = UIView().then {
            $0.backgroundColor = color.darker(by: 15)
        }
    }
    
    private func configureStyle(with colors: CellColors?) {
        if let colors = colors {
            contentView.backgroundColor = colors.background
            innerContentView.backgroundColor = colors.background
            
            configureSelectedBackgroundView(with: colors.background)
            configure(label: nameLabel, withBackground: colors.background, foreground: colors.primary)
            configure(label: categoryLabel, withBackground: colors.background, foreground: colors.secondary)
            configure(label: releaseDateLabel, withBackground: colors.background, foreground: colors.detail)
            configure(label: priceLabel, withBackground: colors.background, foreground: colors.detail)
        }
    }
    
    internal func configure(with viewModel: MovieViewModel) {
        configureStyle(with: viewModel.colors)
        
        posterImageView.image = viewModel.image
        nameLabel.text = viewModel.name
        categoryLabel.text = viewModel.category
        releaseDateLabel.text = viewModel.category
        priceLabel.text = viewModel.price
    }
}
