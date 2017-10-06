import Foundation

internal struct Image: Codable {
    private enum CodingKeys: String, CodingKey {
        case url = "__text"
        case height = "_height"
    }
    
    internal let url: URL
    internal let height: String
}
