import Foundation

internal protocol EnvironmentalVariablesProtocol {
    static var BaseURLString: String { get }
}

internal extension EnvironmentalVariablesProtocol {
    internal static var BaseURL: URL {
        let URLString = BaseURLString
        
        guard let URL = URL(string: URLString) else {
            fatalError("Could not create a URL from \(URLString)")
        }
        
        return URL
    }
}
