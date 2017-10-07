import Foundation

internal struct TopMoviesViewModel {
    internal let movies: [MovieViewModel]
    
    internal init(model: TopMoviesWithMetadata) {
        self.movies = model.topMovies.movies.map { movie in
            MovieViewModel(movie: movie,
                           image: model.imagesMapping[movie.id],
                           colors: model.colorsMapping[movie.id])
        }
    }
}
