import Foundation
import Alamofire
import RxSwift
import KeyedAPIParameters

internal protocol APIClientProtocol {}

// MARK: Void
internal extension APIClientProtocol {
    // Can return a NetworkError or a NSError
    internal func rx_request(_ endpoint: APIEndpoint, params: APIParameters? = nil) -> Single<Void> {
        return rx_request(endpoint, params: params, completionHandler: { _, single in
            single(.success(()))
        })
    }
}

// MARK: Codable
internal extension APIClientProtocol {
    // Can return a NetworkError or a NSError
    internal func rx_request<T: Codable>(_ endpoint: APIEndpoint, params: APIParameters? = nil) -> Single<T> {
        return rx_request(endpoint, params: params, completionHandler: { data, single in
            do {
                single(.success(try JSONDecoder().decode(T.self, from: data)))
            } catch let error {
                single(.error(error))
            }
        })
    }

    // Can return a NetworkError or a NSError
    internal func rx_request<T: Codable>(_ endpoint: APIEndpoint, params: APIParameters? = nil) -> Single<[T]> {
        return rx_request(endpoint, params: params, completionHandler: { data, single in
            do {
                single(.success(try JSONDecoder().decode([T].self, from: data)))
            } catch let error {
                single(.error(error))
            }
        })
    }
}

// MARK: Core
fileprivate extension APIClientProtocol {
    fileprivate func rx_request<T>(_ endpoint: APIEndpoint, params: APIParameters?,
                                   completionHandler: @escaping (Data, ((SingleEvent<T>) -> Void)) -> Void) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            let request = RequestBuilder.buildRequest(for: endpoint, params: params)
            let requestReference = request.validate().responseData(completionHandler: { response in
                switch response.result {
                    case .failure:
                        single(.error(NetworkError(response: response)))
                    case .success(let data):
                        completionHandler(data, single)
                }
            })

            requestReference.resume()

            return Disposables.create {
                requestReference.cancel()
            }
        }
    }
}
