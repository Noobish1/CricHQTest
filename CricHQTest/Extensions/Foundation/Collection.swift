import Foundation
import RxSwift

internal extension Collection where Element: ObservableType {
    internal func zip() -> Observable<[Element.E]> {
        return Observable.zip(self)
    }
}
