import Foundation

internal enum APIEndpoint {
    case topMovies

    internal var url: String {
        switch self {
            case .topMovies: return "topMovies/json"
        }
    }

    internal var method: KeyedHTTPMethod {
        switch self {
            case .topMovies: return .get
        }
    }
}
