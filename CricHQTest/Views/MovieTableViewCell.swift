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
    internal func configure(with movie: Movie, image: UIImage?, colors: CellColors?) {
        if let colors = colors {
            contentView.backgroundColor = colors.background
            innerContentView.backgroundColor = colors.background
            nameLabel.backgroundColor = colors.background
            nameLabel.textColor = colors.primary
            categoryLabel.backgroundColor = colors.background
            categoryLabel.textColor = colors.secondary
            releaseDateLabel.backgroundColor = colors.background
            releaseDateLabel.textColor = colors.detail
            priceLabel.backgroundColor = colors.background
            priceLabel.textColor = colors.detail
        }
        
        posterImageView.image = image
        nameLabel.text = movie.name
        categoryLabel.text = movie.category.name
        releaseDateLabel.text = DateFormatters.releaseDateFormatter.string(from: movie.releaseDate.value)
        priceLabel.text = "\(movie.price.amount) \(movie.price.currency)"
    }
}
