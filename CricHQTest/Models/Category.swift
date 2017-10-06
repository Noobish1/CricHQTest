import Foundation

internal struct Category: Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "_label"
    }
    
    internal let name: String
}
