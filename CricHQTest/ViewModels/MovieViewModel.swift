import UIKit

internal struct MovieViewModel {
    internal let price: String
    internal let releaseDate: String
    internal let category: String
    internal let name: String
    internal let image: UIImage?
    internal let colors: CellColors?
    
    internal init(movie: Movie, image: UIImage?, colors: CellColors?) {
        self.name = movie.name
        self.category = movie.category.name
        self.releaseDate = DateFormatters.releaseDateFormatter.string(from: movie.releaseDate.value)
        self.price = "\(movie.price.amount) \(movie.price.currency)"
        self.colors = colors
        self.image = image
    }
}
