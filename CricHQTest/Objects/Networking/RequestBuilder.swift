import Foundation
import Alamofire
import KeyedAPIParameters

internal final class RequestBuilder {
    fileprivate static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy

        let newManager = SessionManager(configuration: configuration)
        newManager.startRequestsImmediately = false

        return newManager
    }()

    internal static let defaultHeaders: HTTPHeaders = [:]

    internal class func buildRequest(for endpoint: APIEndpoint, params: APIParameters? = nil) -> DataRequest {
        var URL = Environment.Variables.BaseURL
        URL.appendPathComponent(endpoint.url)
        
        return RequestBuilder.manager.request(URL,
                                              method: HTTPMethod(keyedHTTPMethod: endpoint.method),
                                              parameters: params?.toDictionary(forHTTPMethod: endpoint.method),
                                              encoding: endpoint.encoding,
                                              headers: defaultHeaders)
    }
}
