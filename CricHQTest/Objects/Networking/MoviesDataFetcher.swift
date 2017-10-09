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
    private let imageFetcher = ImageFetcher()
    private let imageProcessor = ImageProcessor()
    
    internal weak var delegate: MoviesDataFetcherDelegate?
    
    // MARK: private functions
    private func fetchImages(for topMovies: TopMovies) -> Single<[(Movie, UIImage)]> {
        self.delegate?.dataFetcherDidStartFetchingImages(dataFetcher: self)
        
        return topMovies.movies.map { imageFetcher.downloadImage(for: $0).asObservable() }.zip().asSingle()
    }
    
    private func fetchTopMoviesWithImages() -> Single<[MovieWithImage]> {
        self.delegate?.dataFetcherDidStartFetchingInitialData(dataFetcher: self)
        
        return client.topMovies().flatMap {
            self.fetchImages(for: $0).mapElements(MovieWithImage.init)
        }
    }
    
    // MARK: internal functions
    internal func fetchTopMoviesWithMetadata() -> Single<[MovieWithMetadata]> {
        return fetchTopMoviesWithImages().flatMap { moviesWithImages in
            self.delegate?.dataFetcherDidStartProcessingImages(dataFetcher: self)
            
            return moviesWithImages.map {
                self.imageProcessor.fetchColors(for: $0).asObservable()
            }.zip().asSingle().mapElements(MovieWithMetadata.init)
        }
    }
}

// MARK: Then
extension MoviesDataFetcher: Then {}
