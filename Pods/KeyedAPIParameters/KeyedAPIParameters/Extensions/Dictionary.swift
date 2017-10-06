import Foundation

public extension Dictionary {
    public func mapKeys <K> (_ map: (Key) throws -> K) rethrows -> [K: Value] {
        var mapped = [K: Value]()
        
        try forEach { mapped[try map($0)] = $1 }
        
        return mapped
    }
    
    public func mapValues <V> (_ map: (Value) throws -> V) rethrows -> [Key: V] {
        var mapped = [Key: V]()
        
        try forEach { mapped[$0] = try map($1) }
        
        return mapped
    }
}
