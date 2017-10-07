import Foundation

internal final class Singular {
    // MARK: properties
    private var isDone = false
    
    // MARK: init/deinit
    internal init() {}
    
    // MARK: performing tasks
    internal func performOnce(operation: () -> Void) {
        guard !isDone else { return }
        isDone = true
        
        operation()
    }
}
