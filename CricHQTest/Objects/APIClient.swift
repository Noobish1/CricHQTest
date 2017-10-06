import Foundation
import RxSwift
import Then

internal final class APIClient: APIClientProtocol {
    // MARK: static properties
    internal static var shared = APIClient()
    
    // MARK: instance properties
    internal let jsonDecoder = JSONDecoder().then {
        $0.dateDecodingStrategy = .iso8601
    }
    
    // MARK: API calls
    internal func topMovies() -> Single<TopMovies> {
        return rx_request(.topMovies)
    }
}
