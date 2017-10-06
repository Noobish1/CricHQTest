import Foundation

internal struct Price: Codable {
    private enum CodingKeys: String, CodingKey {
        case text = "__text"
        case currency = "_currency"
    }
    
    internal let text: String
    internal let currency: String
}
