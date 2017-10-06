import Foundation
import Alamofire

internal extension DataResponse {
    internal func withResult<T>(result: Result<T>) -> DataResponse<T> {
        return DataResponse<T>(request: request, response: response, data: data, result: result, timeline: timeline)
    }
}
