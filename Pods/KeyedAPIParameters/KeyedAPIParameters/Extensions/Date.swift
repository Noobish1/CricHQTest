import Foundation

public extension Date {
    public var timeSince1970InMillis: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
