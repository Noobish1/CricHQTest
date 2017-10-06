import Foundation
import Alamofire

public enum NetworkError: Error {
    case noInternet
    case connection(statusCode: Int)

    internal init(response: DataResponse<Data>) {
        if let statusCode = response.response?.statusCode {
            self = .connection(statusCode: statusCode)
        } else {
            self = .noInternet
        }
    }
}
