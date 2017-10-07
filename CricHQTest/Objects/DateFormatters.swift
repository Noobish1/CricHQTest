import Foundation

internal final class DateFormatters {
    internal static let releaseDateFormatter = DateFormatter().then {
        $0.dateFormat = "MMM d, yyyy"
    }
}
