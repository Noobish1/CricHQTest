import Foundation

internal struct Link: Codable {
    private enum CodingKeys: String, CodingKey {
        case url = "_href"
        case type = "_type"
    }
    
    internal let url: URL
    internal let type: String
}
