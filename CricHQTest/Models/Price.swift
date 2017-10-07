import Foundation

internal struct Price: Codable {
    private enum CodingKeys: String, CodingKey {
        case amount = "__text"
        case currency = "_currency"
    }
    
    internal let amount: String
    internal let currency: String
}
