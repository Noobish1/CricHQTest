import Foundation

internal struct TopMovies: Codable {
    private enum CodingKeys: String, CodingKey {
        case movies = "entry"
    }
    
    internal let movies: [Movie]
}
