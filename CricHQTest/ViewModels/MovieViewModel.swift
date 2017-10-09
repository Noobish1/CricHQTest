import UIKit

internal struct MovieViewModel {
    internal let price: String
    internal let releaseDate: String
    internal let category: String
    internal let name: String
    internal let director: String
    internal let summary: String
    internal let image: UIImage?
    internal let colors: InterfaceColors?
    internal let trailerURL: URL?
    
    internal init(movieWithMetaData: MovieWithMetadata) {
        let movie = movieWithMetaData.movie
        
        self.name = movie.name
        self.category = movie.category.name
        self.releaseDate = DateFormatters.releaseDateFormatter.string(from: movie.releaseDate.value)
        self.price = movie.price.amount
        self.director = movie.director
        self.summary = movie.summary
        self.colors = movieWithMetaData.colors
        self.image = movieWithMetaData.image
        self.trailerURL = movie.links.first(where: { $0.type == "video/x-m4v" })?.url
    }
}
