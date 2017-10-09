import Foundation
import RxSwift
import Then

// MARK: MoviesDataFetcherDelegate
internal protocol MoviesDataFetcherDelegate: AnyObject {
    func dataFetcherDidStartFetchingInitialData(dataFetcher: MoviesDataFetcher)
    func dataFetcherDidStartFetchingImages(dataFetcher: MoviesDataFetcher)
    func dataFetcherDidStartProcessingImages(dataFetcher: MoviesDataFetcher)
}

// MARK: MoviesDataFetcher
internal final class MoviesDataFetcher {
    // MARK: properties
    private let client = APIClient()
    internal weak var delegate: MoviesDataFetcherDelegate?
    
    // MARK: private functions
    private func fetchImages(for topMovies: TopMovies) -> Single<[(UUID, UIImage)]> {
        self.delegate?.dataFetcherDidStartFetchingImages(dataFetcher: self)
        
        let requests = topMovies.movies.map { client.downloadImage(for: $0).asObservable() }
        
        return Observable.zip(requests).asSingle()
    }
    
    private func fetchTopMoviesWithImages() -> Single<TopMoviesWithImages> {
        self.delegate?.dataFetcherDidStartFetchingInitialData(dataFetcher: self)
        
        return client.topMovies().flatMap { topMovies in
            self.fetchImages(for: topMovies).map { idImagePairs in
                Dictionary(uniqueKeysWithValues: idImagePairs)
            }.map { imagesMapping in
                TopMoviesWithImages(topMovies: topMovies, imagesMapping: imagesMapping)
            }
        }
    }
    
    private func fetchColors(for movie: Movie, image: UIImage?) -> Maybe<(UUID, CellColors)> {
        guard let image = image else {
            return .empty()
        }
        
        return Maybe<(UUID, CellColors)>.create { single in
            DispatchQueue.global().async {
                let ratio = image.size.width / image.size.height
                let width: CGFloat = 50
                let size = CGSize(width: width, height: width / ratio)
                
                single(.success((movie.id, CellColors(tuple: image.colors(scaleDownSize: size)))))
            }
            
            return Disposables.create()
        }.observeOn(MainScheduler.instance)
    }
    
    // MARK: internal functions
    internal func fetchTopMoviesWithMetadata() -> Single<TopMoviesWithMetadata> {
        return fetchTopMoviesWithImages().flatMap { moviesWithImages in
            self.delegate?.dataFetcherDidStartProcessingImages(dataFetcher: self)
            
            let stuff = moviesWithImages.topMovies.movies.map {
                self.fetchColors(for: $0, image: moviesWithImages.imagesMapping[$0.id]).asObservable()
            }
            
            return Observable.zip(stuff).asSingle().map {
                TopMoviesWithMetadata(topMovies: moviesWithImages.topMovies,
                                      imagesMapping: moviesWithImages.imagesMapping,
                                      colorsMapping: Dictionary(uniqueKeysWithValues: $0))
                
            }
        }
    }
}

// MARK: Then
extension MoviesDataFetcher: Then {}
