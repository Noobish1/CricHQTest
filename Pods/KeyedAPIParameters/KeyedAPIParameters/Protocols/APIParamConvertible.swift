import Foundation

public protocol APIParamConvertible {
    func value(forHTTPMethod method: HTTPMethod) -> Any
}

extension APIParamConvertible where Self: NumberParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        switch method {
            case .get:
                return String(describing: self)
            case .post, .put, .delete:
                return self.toNSNumber()
        }
    }
}

extension String: APIParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        return self
    }
}

extension Int: APIParamConvertible {}
extension Float: APIParamConvertible {}
extension Double: APIParamConvertible {}
extension Bool: APIParamConvertible {}
