import Foundation
import RxSwift
import Then
import Alamofire

internal final class APIClient: APIClientProtocol {
    // MARK: properties
    internal let jsonDecoder = JSONDecoder().then {
        $0.dateDecodingStrategy = .iso8601
    }
    
    // MARK: API calls
    internal func topMovies() -> Single<TopMovies> {
        return rx_request(.topMovies)
    }
}
