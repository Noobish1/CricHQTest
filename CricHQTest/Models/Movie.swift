import Foundation

internal struct Movie: Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case director = "im:artist"
        case category
        case releaseDate = "im:releaseDate"
        case price = "im:price"
        case images = "im:image"
        case summary
    }
    
    internal let id = UUID()
    internal let name: String
    internal let director: String
    internal let category: Category
    internal let releaseDate: ReleaseDate
    internal let price: Price
    internal let images: [Image]
    internal let summary: String
}
