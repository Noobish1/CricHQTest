import UIKit
import RxSwift
import Alamofire

internal final class ImageFetcher {
    internal func downloadImage(for movie: Movie) -> Maybe<(Movie, UIImage)> {
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
                            maybe(.success((movie, image)))
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
