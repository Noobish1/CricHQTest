import Foundation
import RxSwift

internal final class MoviesDataFetcher {
    // MARK: private functions
    private static func fetchImages(for topMovies: TopMovies) -> Single<[(UUID, UIImage)]> {
        let requests = topMovies.movies.map { APIClient.shared.downloadImage(for: $0).asObservable() }
        
        return Observable.zip(requests).asSingle()
    }
    
    private static func fetchTopMoviesWithImages() -> Single<TopMoviesWithImages> {
        return APIClient.shared.topMovies().flatMap { topMovies in
            self.fetchImages(for: topMovies).map { idImagePairs in
                Dictionary(uniqueKeysWithValues: idImagePairs)
            }.map { imagesMapping in
                TopMoviesWithImages(topMovies: topMovies, imagesMapping: imagesMapping)
            }
        }
    }
    
    private static func fetchColors(for movie: Movie, image: UIImage?) -> Maybe<(UUID, CellColors)> {
        guard let image = image else {
            return .empty()
        }
        
        return Maybe<(UUID, CellColors)>.create { single in
            DispatchQueue.global().async {
                single(.success((movie.id, CellColors(tuple: image.colors()))))
            }
            
            return Disposables.create()
        }.observeOn(MainScheduler.instance)
    }
    
    // MARK: internal functions
    internal static func fetchTopMoviesWithMetadata() -> Single<TopMoviesWithMetadata> {
        return fetchTopMoviesWithImages().flatMap({ moviesWithImages in
            let stuff = moviesWithImages.topMovies.movies.map {
                self.fetchColors(for: $0, image: moviesWithImages.imagesMapping[$0.id]).asObservable()
            }
            
            return Observable.zip(stuff).asSingle().map {
                TopMoviesWithMetadata(topMovies: moviesWithImages.topMovies,
                                      imagesMapping: moviesWithImages.imagesMapping,
                                      colorsMapping: Dictionary(uniqueKeysWithValues: $0))
                
            }
        })
    }
}
