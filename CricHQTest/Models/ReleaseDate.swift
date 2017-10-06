import Foundation

internal struct ReleaseDate: Codable {
    private enum CodingKeys: String, CodingKey {
        case value = "__text"
    }
    
    internal let value: Date
}
