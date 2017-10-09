import Foundation
import RxSwift

internal extension Observable where E: Sequence {
    internal func mapElements<R>(_ transform: @escaping (E.Element) throws -> R) -> Observable<[R]> {
        return map { try $0.map(transform) }
    }
}
