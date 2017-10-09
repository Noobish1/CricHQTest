import Foundation
import RxSwift
import Then
import Alamofire

internal final class APIClient: APIClientProtocol {
    // MARK: instance properties
    internal let jsonDecoder = JSONDecoder().then {
        $0.dateDecodingStrategy = .iso8601
    }
    
    // MARK: API calls
    internal func topMovies() -> Single<TopMovies> {
        return rx_request(.topMovies)
    }
    
    internal func downloadImage(for movie: Movie) -> Maybe<(UUID, UIImage)> {
        guard let imageURL = movie.images.first(where: { $0.height == "170" })?.url else {
            return .empty()
        }
        
        return .create { maybe -> Disposable in
            let request = Alamofire.request(imageURL).validate().responseData { response in
                switch response.result {
                    case .failure:
                        maybe(.error(NetworkError(response: response)))
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            maybe(.success((movie.id, image)))
                        } else {
                            maybe(.completed)
                        }
                }
            }
            
            request.resume()
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
