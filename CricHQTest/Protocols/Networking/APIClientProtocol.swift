import Foundation
import Alamofire
import RxSwift
import KeyedAPIParameters
import XMLDictionary

internal protocol APIClientProtocol: class {
    var jsonDecoder: JSONDecoder { get }
}

// MARK: Codable
internal extension APIClientProtocol {
    // Can return a NetworkError or a NSError
    internal func rx_request<T: Codable>(_ endpoint: APIEndpoint, params: APIParameters? = nil) -> Single<T> {
        return rx_request(endpoint, params: params, completionHandler: { [weak self] data, single in
            guard let strongSelf = self else { return }
            
            do {
                guard let jsonObject = XMLDictionaryParser.sharedInstance().dictionary(with: data) else {
                    single(.error(XMLParsingError()))
                    
                    return
                }
                
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
                
                single(.success(try strongSelf.jsonDecoder.decode(T.self, from: jsonData)))
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
        return .create { single -> Disposable in
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
