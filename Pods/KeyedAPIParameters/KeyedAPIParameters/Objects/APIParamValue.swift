import Foundation

public enum APIParamValue: APIParamConvertible {
    case convertible(APIParamConvertible)
    case optionalConvertible(APIParamConvertible?)
    case arrayConvertible([APIParamConvertible])
    case null
    case timestampInMillis(Date)

    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        switch self {
            case .convertible(let convertibleValue):
                return convertibleValue.value(forHTTPMethod: method)
            case .optionalConvertible(let optionalConvertible):
                switch optionalConvertible {
                    case .some(let value): return value.value(forHTTPMethod: method)
                    case .none: return APIParamValue.null.value(forHTTPMethod: method)
                }
            case .arrayConvertible(let arrayConvertible):
                return arrayConvertible.map { $0.value(forHTTPMethod: method) }
            case .null:
                return NSNull()
            case .timestampInMillis(let date):
                switch method {
                    case .get:
                        return String(describing: date.timeSince1970InMillis)
                    case .post, .put, .delete:
                        return NSNumber(value: date.timeSince1970InMillis)
                }
        }
    }
}
