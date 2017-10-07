import UIKit

internal struct TopMoviesWithMetadata {
    internal let topMovies: TopMovies
    internal let imagesMapping: [UUID : UIImage]
    internal let colorsMapping: [UUID: CellColors]
}
