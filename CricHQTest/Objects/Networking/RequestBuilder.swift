import Foundation
import Alamofire
import KeyedAPIParameters
import Then

internal final class RequestBuilder {
    fileprivate static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default.then {
            $0.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            $0.requestCachePolicy = .useProtocolCachePolicy
        }

        return SessionManager(configuration: configuration).then {
            $0.startRequestsImmediately = false
        }
    }()

    internal class func buildRequest(for endpoint: APIEndpoint, params: APIParameters? = nil) -> DataRequest {
        var URL = Environment.Variables.BaseURL
        URL.appendPathComponent(endpoint.url)
        
        return RequestBuilder.manager.request(URL,
                                              method: HTTPMethod(keyedHTTPMethod: endpoint.method),
                                              parameters: params?.toDictionary(forHTTPMethod: endpoint.method),
                                              encoding: endpoint.encoding)
    }
}
