import Foundation

public protocol KeyedAPIParameters: APIParameters {
    associatedtype Key: ParamJSONKey
    
    func toKeyedDictionary() -> [Key: APIParamValue]
}

extension KeyedAPIParameters {
    public func toParamDictionary() -> [String : APIParamValue] {
        return toKeyedDictionary().mapKeys { $0.stringValue }
    }
}
