import Foundation
import RxSwift

internal final class ImageProcessor {
    internal func fetchColors(for movie: MovieWithImage) -> Maybe<(MovieWithImage, InterfaceColors)> {
        guard let image = movie.image else {
            return .empty()
        }
        
        return Maybe.create { single in
            DispatchQueue.global().async {
                single(.success((movie, image.interfaceColors())))
            }
            
            return Disposables.create()
        }.observeOn(MainScheduler.instance)
    }
}
