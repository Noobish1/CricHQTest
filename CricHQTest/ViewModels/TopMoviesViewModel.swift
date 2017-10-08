import Foundation

internal struct TopMoviesViewModel {
    // MARK: properties
    internal let movies: [MovieViewModel]
    
    // MARK: init/deinit
    internal init(model: TopMoviesWithMetadata) {
        self.movies = model.topMovies.movies.map { movie in
            MovieViewModel(movie: movie,
                           image: model.imagesMapping[movie.id],
                           colors: model.colorsMapping[movie.id])
        }
    }
}
