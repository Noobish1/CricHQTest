import UIKit

internal struct MovieWithMetadata {
    internal let movie: Movie
    internal let image: UIImage?
    internal let colors: InterfaceColors?
    
    internal init(movieWithImage: MovieWithImage, colors: InterfaceColors?) {
        self.movie = movieWithImage.movie
        self.image = movieWithImage.image
        self.colors = colors
    }
}
