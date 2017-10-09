import Foundation
import Alamofire

internal enum APIEndpoint {
    case topMovies

    internal var url: String {
        switch self {
            case .topMovies: return "topMovies/xml"
        }
    }

    internal var method: KeyedHTTPMethod {
        switch self {
            case .topMovies: return .get
        }
    }
    
    internal var encoding: ParameterEncoding {
        switch self {
            case .topMovies: return URLEncoding()
        }
    }
}
