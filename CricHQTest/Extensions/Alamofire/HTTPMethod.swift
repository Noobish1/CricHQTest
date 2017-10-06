import Foundation
import Alamofire

internal extension Alamofire.HTTPMethod {
    internal init(keyedHTTPMethod method: KeyedHTTPMethod) {
        switch method {
            case .get: self = .get
            case .post: self = .post
            case .put: self = .put
            case .delete: self = .delete
        }
    }
}
